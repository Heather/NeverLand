{-# LANGUAGE
    GeneralizedNewtypeDeriving
  , NoImplicitPrelude
  #-}
module ApiTypes where

import Prelude.Compat

import Control.Concurrent.STM (TVar)
import Control.Monad.Reader (MonadReader, ReaderT (..))
import Control.Monad.Trans (MonadIO)
-- import Data.HashMap.Strict (HashMap)
import Data.Set (Set)

import Type.Plugin (Plugin)
-- import qualified Type.Plugin as Plugin

data ServerData = ServerData
  { plugins  :: TVar (Set Plugin)
  }

newtype APApi a = APApi { unAPApi :: ReaderT ServerData IO a }
  deriving ( Applicative
           , Functor
           , Monad
           , MonadIO
           , MonadReader ServerData
           )

runAPApi :: ServerData -> APApi a -> IO a
runAPApi serverdata = flip runReaderT serverdata . unAPApi
