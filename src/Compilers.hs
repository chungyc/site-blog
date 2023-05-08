-- |
-- Description: Hakyll compilers for generating the blog.
-- Copyright: Copyright (C) 2023 Yoo Chung
-- License: All rights reserved
-- Maintainer: web@chungyc.org
module Compilers (postCompiler, haskellCompiler) where

import Data.ByteString.Lazy (ByteString)
import Hakyll
import Text.Pandoc.Options

-- | Runs the Haskell code in the underlying file and uses its output.
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

-- | Compiler for a blog post.
postCompiler :: Compiler (Item String)
postCompiler = do
  body <- getResourceBody
  pandoc <- readPandocWith mathReaderOptions body
  return $ writePandocWith mathWriterOptions pandoc

mathReaderOptions :: ReaderOptions
mathReaderOptions =
  defaultHakyllReaderOptions
    { readerExtensions =
        readerExtensions defaultHakyllReaderOptions
          <> extensionsFromList
            [ Ext_tex_math_single_backslash,
              Ext_tex_math_double_backslash,
              Ext_tex_math_dollars,
              Ext_latex_macros
            ]
    }

mathWriterOptions :: WriterOptions
mathWriterOptions =
  defaultHakyllWriterOptions
    { -- We use KaTeX to render math, but the auto-render extension depends
      -- on how Pandoc writes out math in MathJax.  It does not work with
      -- how Pandoc writes out math in KaTeX.
      writerHTMLMathMethod = MathJax ""
    }
