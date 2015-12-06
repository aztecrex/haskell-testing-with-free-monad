module Hello
    ( hello
    ) where

import Op

hello :: FilePath -> Op ()
hello path = do
  c <- readFile' path
  putStrLn' c
