module Hello
    ( hello
    ) where

import Op

hello :: FilePath -> Op ()
hello path = do
  begin <- getTimestamp'
  c <- readFile' path
  putStrLn' $ "Hello, " ++ c
  end <- getTimestamp'
  putStrLn' $ ( show (truncate ( 1000 * ( end - begin ) ) ) ) ++ "ms"
