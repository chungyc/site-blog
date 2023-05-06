-- |
-- Description: Generates default stylesheet for the blog.
-- Copyright: Copyright (C) 2023 Yoo Chung
-- License: All rights reserved
-- Maintainer: web@chungyc.org
module Main where

import Clay
import Clay.Media qualified as Media
import Data.Text.Lazy.IO qualified as T
import Prelude hiding (div, filter, not, (**))

main :: IO ()
main = T.putStr $ renderWith compact [] defaultStyle

defaultStyle :: Css
defaultStyle = do
  genericStyle
  postStyle
  figures
  mediaStyles

genericStyle :: Css
genericStyle = do
  html ? do
    fontFamily ["Georgia", "Garamond"] [serif, sansSerif, monospace]
    textRendering optimizeLegibility
    textAlign justify
    lineHeight $ unitless 1.25
    hyphens auto

  body ? do
    marginTop $ em 2
    marginLeft $ pct 10
    marginRight $ pct 10
    marginBottom $ em 2

  headings

  header ? do
    fontFamily ["Verdana"] [sansSerif, serif, monospace]
    fontSize $ em 0.75
    marginTop $ em 1
    marginBottom $ em 2

  header |> div # ".site-title" ? do
    fontSize $ em 1.5
    marginBottom $ em 0.25

  header |> div # ".slogan" ? do
    marginBottom $ em 0.25
    opacity 0.65

  header |> nav ? do
    paddingTop $ em 1
    marginTop $ em 1
    a ? paddingRight (em 1)
    borderTop (px 1) solid black

  footer ? do
    fontFamily ["Verdana"] [sansSerif, serif, monospace]
    fontSize $ em 0.75
    lineHeight $ unitless 1.5
    paddingTop $ em 1
    marginTop $ em 3
    borderTop (px 1) solid black

  dt ? do
    fontWeight bold
    marginBottom $ em 0.25

  dd ? do
    marginBottom $ em 1

  li |+ li ? marginTop (em 0.75)

  li |> (ul <> ol) ? marginTop (em 0.75)

  blockquote ? do
    marginTop $ em 1
    marginBottom $ em 1
    marginLeft $ em 0
    marginRight $ em 0
    paddingTop $ em 1
    paddingBottom $ em 1
    paddingLeft $ em 3
    paddingRight $ em 3
    fontStyle oblique

headings :: Css
headings = do
  (h1 <> h2 <> h3 <> h4 <> h5 <> h6) ? do
    fontFamily ["Verdana"] [sansSerif, serif, monospace]

  h1 ? fontSize (em 2)
  h2 ? fontSize (em 1.8)
  h3 ? fontSize (em 1.5)
  h4 ? fontSize (em 1.25)
  h5 ? fontSize (em 1.1)

postStyle :: Css
postStyle = do
  article |> section # ".byline" ? do
    fontFamily ["Verdana"] [sansSerif, serif, monospace]
    fontSize $ em 0.7
    p ? do
      marginTop $ em 0.2
      marginBottom $ em 0.2

  article # ".summary" ? do
    sym margin $ em 1
    sym2 padding (em 0) (em 2)
    border (px 1) solid lightgrey

figures :: Css
figures = do
  figure ? do
    display block
    paddingTop $ em 0.5
    paddingBottom $ em 0.5
    marginTop $ em 1
    marginBottom $ em 1
    marginLeft auto
    marginRight auto
    textAlign center

    img ? do
      display block
      marginLeft auto
      marginRight auto
      maxWidth $ pct 95
      maxHeight $ vh 60

    figcaption ? do
      display block
      fontFamily ["Verdana"] [sansSerif, serif, monospace]
      fontSize $ em 0.9
      marginTop $ em 0.5
      marginLeft auto
      marginRight auto

mediaStyles :: Css
mediaStyles = do
  query Media.all [Media.maxWidth $ em 30] $ do
    body ? sym margin (em 1)

    ul <> ol ? do
      marginLeft $ em 0.5
      paddingLeft $ em 0.5

  query Media.all [Media.minWidth $ em 60] $ do
    body ? do
      width $ em 60
      marginRight auto
      marginLeft auto

  query Media.all [Media.prefersColorScheme Media.light] lightColorScheme

  query Media.all [Media.prefersColorScheme Media.dark] darkColorScheme

headingColors :: (Integer -> Color) -> Css
headingColors mapColor = do
  h1 ? fontColor (mapColor 1)
  h2 ? fontColor (mapColor 2)
  h3 ? fontColor (mapColor 3)
  h4 ? fontColor (mapColor 4)
  h5 ? fontColor (mapColor 5)
  h6 ? fontColor (mapColor 6)

lightColorScheme :: Css
lightColorScheme = do
  html ? do
    color black
    backgroundColor white

  a # link ? color blue
  a # visited ? color purple

  headingColors headingColor

  header |> (div # ".site-title" <> div # ".slogan") ? do
    fontColor $ rgb 6 63 120

  footer ? do
    fontColor $ rgb 6 63 120

  blockquote ? do
    backgroundColor $ rgb 245 245 245
  where
    headingColor n = rgb (n * 20) (n * 20) (100 + n * 10)

darkColorScheme :: Css
darkColorScheme = do
  html ? do
    color white
    backgroundColor black

  footer ? borderTop (px 1) solid white

  a # link ? color cyan
  a # visited ? color pink

  headingColors headingColor

  header |> (div # ".site-title" <> div # ".slogan") ? do
    fontColor $ rgb 187 219 250

  footer ? do
    fontColor $ rgb 187 219 250

  article # ".summary" ? do
    sym margin $ em 1
    sym padding $ em 1

  blockquote ? do
    backgroundColor $ rgb 30 30 30

  figure |> img # (not ".keep-colors" <> "src" $= ".svg") ? do
    filter (invert $ pct 100)
  where
    headingColor n = rgb (255 - n * 20) (255 - n * 20) (155 - n * 10)
