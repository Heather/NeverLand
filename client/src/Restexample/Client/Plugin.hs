{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
module Restexample.Client.Plugin where
import Rest.Client.Internal
import qualified Rest.Types.Void
import qualified Rest.Types.Container
import qualified Type.PluginInfo

type Identifier = String

readId :: Identifier -> [String]
readId x = ["name", showUrl x]

list ::
       ApiStateC m =>
       [(String, String)] ->
         m (ApiResponse Rest.Types.Void.Void
              (Rest.Types.Container.List (Type.PluginInfo.PluginInfo)))
list pList
  = let rHeaders
          = [(hAccept, "text/json"), (hContentType, "text/plain")]
        request = makeReq "GET" "v1.0.0" [["plugin"]] pList rHeaders ""
      in doRequest fromJSON fromJSON request
