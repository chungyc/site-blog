module Main (main) where

import Config
import Hakyll
import Rules

main :: IO ()
main = hakyllWith config rules
