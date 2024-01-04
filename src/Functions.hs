-- |
-- Description: Functions that can be used in Hakyll templates.
-- Copyright: Copyright (C) 2024 Yoo Chung
-- License: All rights reserved
-- Maintainer: web@chungyc.org
module Functions (youtubeField) where

import Data.String (fromString)
import Hakyll
import Text.Blaze (customAttribute)
import Text.Blaze.Html.Renderer.String (renderHtml)
import Text.Blaze.Html5 (div, iframe, (!))
import Text.Blaze.Html5.Attributes (class_, height, src, title, width)
import Prelude hiding (div)

-- |
-- Function field for embedding YouTube videos.
--
-- In the template, the function is named @youtube@.
-- It can be passed in either one or three arguments.
--
-- When there is only one argument, it is:
--
-- * URL of the video
--
-- When there are three arguments, they are:
-- 
-- * URL of the video
-- * width of the video
-- * height of the video
--
-- For example,
--
-- > $youtube("https://www.youtube.com/embed/S7TUe5w6RHo")$
-- > $youtube("https://www.youtube.com/embed/S7TUe5w6RHo", "560", "315")$
--
youtubeField :: Context String
youtubeField = functionField "youtube" $ pure . pure . embed
  where
    embed [url] = renderHtml $ container (url, "560", "315")
    embed [url, w, h] = renderHtml $ container (url, w, h)
    embed _ = error "wrong number of arguments; expected (url, width, height)"

    container p = div (video p) ! class_ "embedded-video"

    video (url, w, h) =
      iframe ""
        ! src (fromString url)
        ! width (fromString w)
        ! height (fromString h)
        ! title "YouTube video player"
        ! customAttribute "frameborder" "0"
        ! customAttribute "allowfullscreen" ""
        ! customAttribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
