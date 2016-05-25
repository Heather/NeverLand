{-# LANGUAGE NoImplicitPrelude #-}
module Api.Plugin (resource) where

import Prelude.Compat

import Control.Concurrent.STM (atomically, readTVar) -- modifyTVar
-- import Control.Monad.Error.Class (throwError)
import Control.Monad.Reader (ReaderT, asks)
import Control.Monad.Trans (liftIO)
import Control.Monad.Trans.Except (ExceptT)
-- import Data.Set (Set)
-- import qualified Data.Foldable as F
import qualified Data.Set      as Set
import qualified Data.Text     as T

import Rest
import qualified Rest.Resource as R

import ApiTypes (APApi, ServerData (..))
import Type.Plugin (Plugin)
import Type.PluginInfo (PluginInfo (..))
import qualified Type.Plugin     as Plugin
import qualified Type.PluginInfo as PluginInfo

-- | Plugin extends the root of the API with a reader containing the ways to identify a plugin in our URLs.
-- Currently only by the plugin name.
type WithPlugin = ReaderT Plugin.Name APApi

-- | Defines the /plugin api end-point.
resource :: Resource APApi WithPlugin Plugin.Name () Void
resource = mkResourceReader
  { R.name   = "plugin" -- Name of the HTTP path segment.
  , R.schema = withListing () $ named [("name", singleBy T.pack)]
  , R.list   = const list -- requested by GET /plugin, gives a paginated listing of plugins.
  -- , R.create = Just create -- PUT /plugin creates a new plugin
  }

list :: ListHandler APApi
list = mkListing xmlJsonO handler
  where
    handler :: Range -> ExceptT Reason_ APApi [PluginInfo]
    handler r = do
      plgs <- liftIO . atomically . readTVar =<< asks plugins
      return . map toPluginInfo . take (count r) . drop (offset r) . Set.toList $ plgs

-- | Convert a Plugin into a representation that is safe to show to the public.
toPluginInfo :: Plugin -> PluginInfo
toPluginInfo u = PluginInfo { PluginInfo.name = Plugin.name u }
