-- |
-- Description: Configuration for generating the blog.
-- Copyright: Copyright (C) 2023 Yoo Chung
-- License: All rights reserved
-- Maintainer: web@chungyc.org
module Config (config) where

import Hakyll

-- | Hakyll configuration for generating the blog.
config :: Configuration
config =
  defaultConfiguration
    { providerDirectory = "site",
      deployCommand =
        unwords
          [ "rsync",
            "--checksum",
            "--compress",
            "--delete",
            "--exclude .well-known",
            "--links",
            "--recursive",
            "--verbose",
            "_site/",
            "chungyc@chungyc.org:blog.chungyc.org/"
          ]
    }
