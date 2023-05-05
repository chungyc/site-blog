-- |
-- Description: Icons for the blog.
-- Copyright: Copyright (C) 2023 Yoo Chung
-- License: All rights reserved
-- Maintainer: web@chungyc.org
module Icons (generateIcon, favicon) where

import Data.ByteString.Lazy (ByteString)
import Diagrams.Backend.SVG
import Diagrams.Prelude
import Graphics.Svg
import Hakyll
import System.Random

generateIcon :: Diagram B -> Compiler (Item ByteString)
generateIcon = makeItem . renderBS . renderDia SVG options . pad 1.1
  where
    options = SVGOptions (mkWidth 256) Nothing "" [] True

favicon :: Diagram B
favicon = cubicSpline True points # lineColor slateblue
  where
    points = take 100 $ zipWith (curry p2) xs ys
    xs = randomRs (-1, 1) $ mkStdGen 3247823487
    ys = randomRs (-1, 1) $ mkStdGen 2666648913
