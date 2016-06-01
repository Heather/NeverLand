{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE UnicodeSyntax              #-}

module ApiTypes where

import           Prelude.Compat

import           Control.Concurrent.STM (TVar)
import           Control.Monad.Reader   (MonadReader, ReaderT (..))
import           Control.Monad.Trans    (MonadIO)
-- import Data.HashMap.Strict (HashMap)
import           Data.Set               (Set)

import           Type.Plugin            (Plugin)
-- import qualified Type.Plugin as Plugin

data ServerData = ServerData
  { plugins :: TVar (Set Plugin)
  }

newtype APApi α = APApi { unAPApi :: ReaderT ServerData IO α }
  deriving ( Applicative
           , Functor
           , Monad
           , MonadIO
           , MonadReader ServerData
           )

runAPApi ∷ ServerData → APApi α → IO α
runAPApi serverdata = flip runReaderT serverdata . unAPApi
