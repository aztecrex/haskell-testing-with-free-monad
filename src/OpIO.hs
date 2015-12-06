module OpIO (run) where

import Hello
import Op
import Control.Monad.Free

run :: Op r -> IO r
run (Pure r) = return r
run (Free (PutStrLn s t)) = putStrLn s >> run t
run (Free (ReadFile p f)) = readFile p >>=  run . f
