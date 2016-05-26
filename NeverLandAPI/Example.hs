{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Example (exampleAP) where

import           Prelude.Compat

import           Control.Concurrent.STM (newTVarIO)
-- import Data.HashMap.Strict (HashMap)
import           Data.Set               (Set)
-- import qualified Data.HashMap.Strict as H
import qualified Data.Set               as Set

import           ApiTypes               (ServerData (..))
import           Type.Plugin            (Plugin (Plugin))

-- Set up the server state
exampleAP :: IO ServerData
exampleAP = ServerData <$> newTVarIO mockPlugins

-- | Prepoulated plugins
mockPlugins :: Set Plugin
mockPlugins = Set.fromList
  [ Plugin "plugin 1" "1234"
  , Plugin "plugin 2" "2345"
  , Plugin "plugin 3" "3456"
  ]
