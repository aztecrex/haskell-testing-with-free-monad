module Hello
    ( hello
    ) where

import Op

hello ::  Op ()
hello = do
  (path : _) <- getArgs'
  begin <- getTimestamp'
  c <- readFile' path
  putStrLn' $ "Hello, " ++ c
  end <- getTimestamp'
  putStrLn' $ ( show (truncate ( 1000 * ( end - begin ) ) ) ) ++ "ms"
