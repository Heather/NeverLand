{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
module Type.Plugin where

import           Data.Aeson
import           Data.JSON.Schema
import           Data.Text                 (Text)
import           Data.Typeable
import           Generics.Generic.Aeson
import           Generics.XmlPickler
import           GHC.Generics
import           Text.XML.HXT.Arrow.Pickle

type Name = Text
type Password = Text

data Plugin = Plugin
  { name     :: Name
  , password :: Password
  } deriving (Eq, Generic, Ord, Show, Typeable)

instance XmlPickler Plugin where xpickle   = gxpickle
instance JSONSchema Plugin where schema    = gSchema
instance FromJSON   Plugin where parseJSON = gparseJson
instance ToJSON     Plugin where toJSON    = gtoJson
-- We might want to skip the ToJSON instance so we don't accidentally
-- serve passwords, but this type is accepted on signup which means a
-- haskell client needs to be able to serialize it.
