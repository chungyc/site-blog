-- |
-- Description: Rules for generating the blog.
-- Copyright: Copyright (C) 2024 Yoo Chung
-- License: All rights reserved
-- Maintainer: web@chungyc.org
module Rules (rules) where

import Compilers
import Functions
import Hakyll
import Icons

-- | Rules for generating the blog.
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

  match "server/humans.txt" $ do
    route $ constRoute "humans.txt"
    compile copyFileCompiler

  create ["favicon.svg"] $ do
    route idRoute
    compile $ makeItem $ generateSvg favicon

  match "server/errors/*.markdown" $ do
    route $ setExtension "html"
    compile $
      pandocCompiler
        >>= loadAndApplyTemplate defaultTemplate blogContext

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
                blogContext
              ]

      makeItem ""
        >>= saveSnapshot "sitemap"
        >>= loadAndApplyTemplate "templates/front.html" frontContext
        >>= loadAndApplyTemplate defaultTemplate frontContext

  match "about.markdown" $ do
    route $ constRoute "about/index.html"
    compile $
      pandocCompiler
        >>= saveSnapshot "sitemap"
        >>= loadAndApplyTemplate defaultTemplate blogContext

  create ["archives/index.html"] $ do
    route idRoute
    compile $ do
      posts <- recentFirst =<< loadAllSnapshots "posts/**.markdown" "posts"

      let archiveContext =
            mconcat
              [ listField "posts" postContext (pure posts),
                constField "description" "Archive of posts for the Stochastic Scribbles blog.",
                constField "title" "Archives",
                blogContext
              ]

      makeItem ""
        >>= saveSnapshot "sitemap"
        >>= loadAndApplyTemplate "templates/archive.html" archiveContext
        >>= loadAndApplyTemplate defaultTemplate archiveContext

  match "contact.markdown" $ do
    route $ constRoute "contact/index.html"
    compile $
      pandocCompiler
        >>= saveSnapshot "sitemap"
        >>= loadAndApplyTemplate defaultTemplate blogContext

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

  match "posts/**.png" $ do
    route stripPrefix
    compile copyFileCompiler

  match "posts/**.jpg" $ do
    route stripPrefix
    compile copyFileCompiler

  create ["feed/index.xml"] $ do
    route idRoute
    compile $ do
      let feedContext =
            mconcat
              [ teaserField "description" "posts",
                bodyField "description",
                blogContext
              ]
      posts <- fmap (take 10) . recentFirst =<< loadAllSnapshots "posts/**.markdown" "posts"
      renderRss feedConfiguration feedContext posts
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
      let sitemapContext = listField "items" blogContext (return itemList) <> blogContext
      makeItem "" >>= loadAndApplyTemplate "templates/sitemap.xml" sitemapContext
  where
    patterns =
      "index.html"
        .||. "about.markdown"
        .||. "archives/index.html"
        .||. "posts/**.markdown"

-- | Default templates for HTML pages.
defaultTemplate :: Identifier
defaultTemplate = "templates/default.html"

-- | Context to be used for blog posts.
postContext :: Context String
postContext = functionFields <> teaserField "teaser" "posts" <> blogContext
  where
    functionFields = youtubeField

-- | Context to be used for all HTML pages.
blogContext :: Context String
blogContext = field "url" clean <> defaultContext
  where
    -- Clean up "index.html" from URLs.
    clean item = do
      path <- getRoute (itemIdentifier item)
      case path of
        Nothing -> noResult "no route for identifier"
        Just s -> pure . cleanupUrl . toUrl $ s

-- | Clean up "index.html" from a local URL.
cleanupUrl :: String -> String
cleanupUrl url@('/' : _)
  | Nothing <- prefix = url
  | Just s <- prefix = s
  where
    prefix = needlePrefix "index.html" url
cleanupUrl url = url
