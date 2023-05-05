-- |
-- Description: Hakyll compilers for generating the blog.
-- Copyright: Copyright (C) 2023 Yoo Chung
-- License: All rights reserved
-- Maintainer: web@chungyc.org
module Compilers (haskellCompiler) where

import Data.ByteString.Lazy (ByteString)
import Hakyll

haskellCompiler :: Compiler (Item ByteString)
haskellCompiler = do
  file <- getResourceFilePath
  emptyItem >>= withItemBody (run file)
  where
    run f = unixFilterLBS "runhaskell" $ args ++ [f]
    args = ["-XGHC2021", "-XOverloadedStrings"]

    -- We will run the code from the file directly,
    -- so we don't care about any content in an item.
    emptyItem = makeItem ""
