{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE UnicodeSyntax      #-}

module Type.PluginInfo where

import           Data.Aeson
import           Data.JSON.Schema
import           Data.Typeable
import           Generics.Generic.Aeson
import           Generics.XmlPickler
import           GHC.Generics
import           Text.XML.HXT.Arrow.Pickle

import qualified Type.Plugin               as Plugin

data PluginInfo = PluginInfo
  { name :: Plugin.Name
  } deriving (Generic, Show, Typeable)

instance XmlPickler PluginInfo where xpickle   = gxpickle
instance JSONSchema PluginInfo where schema    = gSchema
instance FromJSON   PluginInfo where parseJSON = gparseJson
instance ToJSON     PluginInfo where toJSON    = gtoJson
