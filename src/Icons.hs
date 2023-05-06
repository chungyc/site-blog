-- |
-- Description: Icons for the blog.
-- Copyright: Copyright (C) 2023 Yoo Chung
-- License: All rights reserved
-- Maintainer: web@chungyc.org
module Icons (generateSvg, favicon) where

import Data.ByteString.Lazy (ByteString)
import Data.Char (ord)
import Diagrams.Backend.SVG
import Diagrams.Prelude
import Graphics.Svg
import System.Random

generateSvg :: Diagram B -> ByteString
generateSvg = renderBS . renderDia SVG options . pad 1.1
  where
    options = SVGOptions (mkWidth 256) Nothing "" [] True

favicon :: Diagram B
favicon = cubicSpline True points # lineColor steelblue
  where
    points = take 100 $ zipWith (curry p2) xs ys
    xs = randomDoubles "Stochastic"
    ys = randomDoubles "Scribbles"
    randomDoubles = randomRs (-1.0, 1.0) . mkStdGen . toIntSeed

toIntSeed :: String -> Int
toIntSeed [] = 0
toIntSeed (c : cs) = ord c + 91 * toIntSeed cs
