{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE UnicodeSyntax     #-}

module Main (main) where

import           Network.Wai.Handler.Warp
import           Rest.Driver.Wai          (apiToApplication)

import           Api                      (api)
import           ApiTypes                 (runAPApi)
import           Example                  (exampleAP)

main ∷ IO ()
main = do

  -- Set up the server state for the blog and start warp.
  putStrLn "Starting warp server on http://localhost:3000"
  serverData <- exampleAP
  run 3000 $ apiToApplication (runAPApi serverData) api
