import Restexample.Client.Plugin as Plugin

import Rest.Client.Base

import Control.Monad

runZ :: String -> ApiT IO a -> IO a
runZ = flip runWithPort 3000

main :: IO ()
main = do
  res <- runZ "localhost" (Plugin.list [])
  case responseBody res of
        Right r ->
          forM_ r $ \rx ->
            print rx
        Left e -> print e
