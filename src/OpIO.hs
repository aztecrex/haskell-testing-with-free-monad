module OpIO (run) where

import Hello
import Op
import Control.Monad.Free
import Data.Time.Clock.POSIX

run :: Op r -> IO r
run (Pure r) = return r
run (Free (PutStrLn s t)) = putStrLn s >> run t
run (Free (ReadFile p f)) = readFile p >>=  run . f
run (Free (GetPOSIXTime f)) = getPOSIXTime >>= run . f
