-- |
-- Description: Configuration for generating the blog.
-- Copyright: Copyright (C) 2023 Yoo Chung
-- License: All rights reserved
-- Maintainer: web@chungyc.org
module Config (config) where

import Hakyll

config :: Configuration
config = defaultConfiguration {providerDirectory = "site"}
