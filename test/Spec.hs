import Hello
import Op
import Control.Monad.Free
import Data.Time.Clock
import Test.QuickCheck
import Test.QuickCheck.Instances

main :: IO ()
main = do
  print $ runPure ( hello "hi" ) [10000000,1000000003]
  quickCheck greetsFileContents
  quickCheck outputsElapsedTime

-- first thing output is the file contents modified with greeting
greetsFileContents :: String -> DiffTime -> DiffTime -> Bool
greetsFileContents p start end = firstOut == greet contents
  where firstOut = runPure (hello p) [start,end] !! 0
        contents = "contents of " ++ p
        greet = ("Hello, " ++)

-- second thing output is elapsed time in s
outputsElapsedTime :: String -> DiffTime -> DiffTime -> Bool
outputsElapsedTime p start end = secondOut == elapsed
  where secondOut = runPure (hello p) [start,end] !! 1
        elapsed = ( show (truncate ( 1000 * ( end - start ) ) ) ) ++ "ms"

runPure :: Op r -> [DiffTime] -> [String]
runPure (Pure r) _ = []
runPure (Free (PutStrLn s t)) ts = s:runPure t ts
runPure (Free (ReadFile p f)) ts  = runPure (f $ "contents of " ++ p) ts
runPure (Free (GetTimestamp f)) (t:ts) = runPure (f t) ts
