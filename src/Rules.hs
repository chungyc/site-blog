-- |
-- Description: Rules for generating the blog.
-- Copyright: Copyright (C) 2023 Yoo Chung
-- License: All rights reserved
-- Maintainer: web@chungyc.org
module Rules (rules) where

import Hakyll

rules :: Rules ()
rules = do
  templateRules
  sitemapRules
  serverRules
  pageRules
  postRules

templateRules :: Rules ()
templateRules = match "templates/*" $ compile templateBodyCompiler

serverRules :: Rules ()
serverRules = do
  match "server/htaccess" undefined

  match "server/robots.txt" undefined

  match "server/favicon.png" undefined

  match "server/errors/*.markdown" undefined

pageRules :: Rules ()
pageRules = do
  create ["index.html"] $ do
    route idRoute
    undefined

  match "about.markdown" $ do
    route $ constRoute "about/index.html"
    compile $
      pandocCompiler
        >>= loadAndApplyTemplate defaultTemplate defaultContext
        >>= cleanupUrls

  create ["archives/index.html"] $ do
    route idRoute
    undefined

postRules :: Rules ()
postRules = do
  match "posts/**.markdown" $ do
    route $ composeRoutes replacePrefix replaceSuffix
    compile $
      pandocCompiler
        >>= saveSnapshot "posts"
        >>= loadAndApplyTemplate defaultTemplate defaultContext
        >>= loadAndApplyTemplate "templates/post.html" defaultContext
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
      posts <- recentFirst =<< loadAllSnapshots "**" "posts"
      renderRss feedConfiguration feedContext posts
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
    undefined

defaultTemplate :: Identifier
defaultTemplate = "templates/default.html"

cleanupUrls :: Item String -> Compiler (Item String)
cleanupUrls = pure . fmap (withUrls cleanupUrl)

cleanupUrl :: String -> String
cleanupUrl = undefined
