{-# LANGUAGE UnicodeSyntax #-}

module Api where

import           ApiTypes   (APApi)

import qualified Api.Plugin as Plugin

import           Rest.Api
-- import Rest

-- import qualified Rest.Resource as R

type Title = String

-- | Defines a versioned api
api ∷ Api APApi
api = Versioned [(mkVersion 1 0 0, Some1 ap)]

-- | The entire routing table for v1.0.0 of the blog
ap ∷ Router APApi APApi
ap =
  root -/ plugin
  where
    plugin = route Plugin.resource
