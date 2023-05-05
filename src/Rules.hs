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

templateRules :: Rules ()
templateRules = match "templates/*" $ compile templateBodyCompiler

serverRules :: Rules ()
serverRules = do
  match "server/htaccess" $ do
    route $ constRoute ".htaccess"
    compile copyFileCompiler

  match "server/robots.txt" $ do
    route $ constRoute "robots.txt"
    compile copyFileCompiler

  create ["favicon.svg"] $ do
    route idRoute
    compile $ generateIcon favicon

  match "server/errors/*.markdown" $ do
    route $ setExtension "html"
    compile $
      pandocCompiler
        >>= loadAndApplyTemplate defaultTemplate defaultContext
        >>= cleanupUrls

styleRules :: Rules ()
styleRules = do
  match "styles/**.css" $ do
    route idRoute
    compile compressCssCompiler

  match "styles/**.hs" $ do
    route $ setExtension "css"
    compile haskellCompiler

pageRules :: Rules ()
pageRules = do
  create ["index.html"] $ do
    route idRoute
    compile $ do
      posts <- fmap (take 10) . recentFirst =<< loadAllSnapshots "posts/**" "posts"

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
      posts <- recentFirst =<< loadAllSnapshots "posts/**" "posts"

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

postRules :: Rules ()
postRules = do
  match "posts/**.markdown" $ do
    route $ composeRoutes replacePrefix replaceSuffix
    compile $
      postCompiler
        >>= saveSnapshot "sitemap"
        >>= saveSnapshot "posts"
        >>= loadAndApplyTemplate "templates/post.html" postContext
        >>= loadAndApplyTemplate defaultTemplate postContext
        >>= cleanupUrls

  create ["feed/index.xml"] $ do
    route idRoute
    compile $ do
      let feedContext =
            mconcat
              [ teaserField "posts" "description",
                bodyField "description",
                defaultContext
              ]
      posts <- recentFirst =<< loadAllSnapshots "posts/**" "posts"
      renderRss feedConfiguration feedContext posts >>= cleanupUrls
  where
    replacePrefix = gsubRoute "^posts/" (const "")
    replaceSuffix = gsubRoute "\\.markdown$" (const "/index.html")

    feedConfiguration =
      FeedConfiguration
        { feedTitle = "Stochastic Scribbles",
          feedDescription = "Posts from Stochastic Scribbles, a blog by Yoo Chung.",
          feedAuthorName = "Yoo Chung",
          feedAuthorEmail = "web@chungyc.org",
          feedRoot = "https://blog.chungyc.org"
        }

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

defaultTemplate :: Identifier
defaultTemplate = "templates/default.html"

cleanupUrls :: Item String -> Compiler (Item String)
cleanupUrls = pure . fmap (withUrls cleanupUrl)

cleanupUrl :: String -> String
cleanupUrl url@('/' : _)
  | Nothing <- prefix = url
  | Just s <- prefix = s
  where
    prefix = needlePrefix "index.html" url
cleanupUrl url = url

postContext :: Context String
postContext = defaultContext
