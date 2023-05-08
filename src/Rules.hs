-- |
-- Description: Rules for generating the blog.
-- Copyright: Copyright (C) 2023 Yoo Chung
-- License: All rights reserved
-- Maintainer: web@chungyc.org
module Rules (rules) where

import Compilers
import Hakyll
import Icons

rules :: Rules ()
rules = do
  templateRules
  serverRules
  styleRules
  pageRules
  postRules
  sitemapRules

-- | Rules for loading templates.
templateRules :: Rules ()
templateRules = match "templates/*" $ compile templateBodyCompiler

-- | Rules for generating server configuration.
--
-- E.g., Apache configuration, favicon, etc.
serverRules :: Rules ()
serverRules = do
  match "server/htaccess" $ do
    route $ constRoute ".htaccess"
    compile copyFileCompiler

  match "server/feed/htaccess" $ do
    route $ constRoute "feed/.htaccess"
    compile copyFileCompiler

  match "server/robots.txt" $ do
    route $ constRoute "robots.txt"
    compile copyFileCompiler

  create ["favicon.svg"] $ do
    route idRoute
    compile $ makeItem $ generateSvg favicon

  match "server/errors/*.markdown" $ do
    route $ setExtension "html"
    compile $
      pandocCompiler
        >>= loadAndApplyTemplate defaultTemplate defaultContext
        >>= cleanupUrls

-- | Rules for generating the stylesheets for the blog.
styleRules :: Rules ()
styleRules = do
  match "styles/**.css" $ do
    route idRoute
    compile compressCssCompiler

  match "styles/**.hs" $ do
    route $ setExtension "css"
    compile haskellCompiler

-- | Rules for generating the non-post pages for the blog.
pageRules :: Rules ()
pageRules = do
  create ["index.html"] $ do
    route idRoute
    compile $ do
      posts <- fmap (take 5) . recentFirst =<< loadAllSnapshots "posts/**.markdown" "posts"

      let frontContext =
            mconcat
              [ boolField "front" (const True),
                listField "posts" postContext (pure posts),
                constField "description" "Random musings in a variety of subjects, from science to religion.",
                constField "title" "Archives",
                defaultContext
              ]

      makeItem ""
        >>= saveSnapshot "sitemap"
        >>= loadAndApplyTemplate "templates/front.html" frontContext
        >>= loadAndApplyTemplate defaultTemplate frontContext
        >>= cleanupUrls

  match "about.markdown" $ do
    route $ constRoute "about/index.html"
    compile $
      pandocCompiler
        >>= saveSnapshot "sitemap"
        >>= loadAndApplyTemplate defaultTemplate defaultContext
        >>= cleanupUrls

  create ["archives/index.html"] $ do
    route idRoute
    compile $ do
      posts <- recentFirst =<< loadAllSnapshots "posts/**.markdown" "posts"

      let archiveContext =
            mconcat
              [ listField "posts" postContext (pure posts),
                constField "description" "Archive of posts for the Stochastic Scribbles blog.",
                constField "title" "Archives",
                defaultContext
              ]

      makeItem ""
        >>= saveSnapshot "sitemap"
        >>= loadAndApplyTemplate "templates/archive.html" archiveContext
        >>= loadAndApplyTemplate defaultTemplate archiveContext
        >>= cleanupUrls

  match "contact.markdown" $ do
    route $ constRoute "contact/index.html"
    compile $
      pandocCompiler
        >>= saveSnapshot "sitemap"
        >>= loadAndApplyTemplate defaultTemplate defaultContext
        >>= cleanupUrls

-- | Rules for generating the blog posts.
postRules :: Rules ()
postRules = do
  match "posts/**.markdown" $ do
    route $ composeRoutes stripPrefix replaceSuffix
    compile $
      postCompiler
        >>= saveSnapshot "sitemap"
        >>= saveSnapshot "posts"
        >>= loadAndApplyTemplate "templates/post.html" postContext
        >>= loadAndApplyTemplate defaultTemplate postContext
        >>= cleanupUrls

  match "posts/**.png" $ do
    route stripPrefix
    compile copyFileCompiler

  match "posts/**.jpg" $ do
    route stripPrefix
    compile copyFileCompiler

  create ["feed/index.xml"] $ do
    route idRoute
    compile $ do
      -- Used to strip "index.html" from the URLs.
      let toCleanLink item = do
            path <- getRoute (itemIdentifier item)
            case path of
              Nothing -> noResult "no route for identifier"
              Just s -> pure . cleanupUrl . toUrl $ s

      let feedContext =
            mconcat
              [ field "url" toCleanLink,
                teaserField "description" "posts",
                bodyField "description",
                defaultContext
              ]
      posts <- recentFirst =<< loadAllSnapshots "posts/**.markdown" "posts"
      renderRss feedConfiguration feedContext posts >>= cleanupUrls
  where
    stripPrefix = gsubRoute "^posts/" (const "")
    replaceSuffix = gsubRoute "\\.markdown$" (const "/index.html")

    feedConfiguration =
      FeedConfiguration
        { feedTitle = "Stochastic Scribbles",
          feedDescription = "Posts from Stochastic Scribbles, a blog by Yoo Chung.",
          feedAuthorName = "Yoo Chung",
          feedAuthorEmail = "web@chungyc.org",
          feedRoot = "https://blog.chungyc.org"
        }

-- | Rules for generating the sitemap.
sitemapRules :: Rules ()
sitemapRules = do
  create ["sitemap.xml"] $ do
    route idRoute
    compile $ do
      itemList <- loadAllSnapshots patterns "sitemap"

      let itemContext = functionField "clean" clean <> defaultContext

      let sitemapContext =
            mconcat
              [ listField "items" itemContext (return itemList),
                defaultContext
              ]

      makeItem "" >>= loadAndApplyTemplate "templates/sitemap.xml" sitemapContext
  where
    clean [url@('/' : _)] _
      | Nothing <- prefix = return $ root ++ url
      | Just s <- prefix = return $ root ++ s
      where
        prefix = needlePrefix "index.html" url
        root = "https://blog.chungyc.org"
    clean [url] _ = return url
    clean _ _ = error "wrong number of arguments"

    patterns =
      "index.html"
        .||. "about.markdown"
        .||. "archives/index.html"
        .||. "posts/**.markdown"

-- | Default templates for HTML pages.
defaultTemplate :: Identifier
defaultTemplate = "templates/default.html"

-- | Clean up "index.html" from URLs in HTML items.
cleanupUrls :: Item String -> Compiler (Item String)
cleanupUrls = pure . fmap (withUrls cleanupUrl)

-- | Clean up "index.html" from a given local URL.
cleanupUrl :: String -> String
cleanupUrl url@('/' : _)
  | Nothing <- prefix = url
  | Just s <- prefix = s
  where
    prefix = needlePrefix "index.html" url
cleanupUrl url = url

-- | Context to be used for blog posts.
postContext :: Context String
postContext = teaserField "teaser" "posts" <> defaultContext
