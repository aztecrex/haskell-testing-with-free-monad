module Hello
    ( hello
    ) where

import Op

hello :: FilePath -> Op ()
hello path = do
  begin <- getPOSIXTime'
  c <- readFile' path
  putStrLn' $ "Hello, " ++ c
  end <- getPOSIXTime'
  putStrLn' $ show $ end - begin
