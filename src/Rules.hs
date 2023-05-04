{- |
Description: Rules for generating the blog.
Copyright: Copyright (C) 2023 Yoo Chung
License: All rights reserved
Maintainer: web@chungyc.org
-}
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
  match "about.markdown" $ do
    route $ constRoute "about/index.html"
    compile $ pandocCompiler
      >>= loadAndApplyTemplate undefined defaultContext

  match "policies.markdown" $ do
    route $ constRoute "policies/index.html"
    compile $ pandocCompiler
      >>= loadAndApplyTemplate undefined defaultContext

  create ["archives/index.html"] $ do
    route idRoute
    undefined

postRules :: Rules ()
postRules = do
  match "posts/**.markdown" undefined

sitemapRules :: Rules ()
sitemapRules = undefined
