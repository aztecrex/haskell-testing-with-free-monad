import Hello
import Op
import Control.Monad.Free
import Data.Time.Clock
import Test.QuickCheck
import Test.QuickCheck.Instances

main :: IO ()
main = do
  putStrLn ""
  quickCheck greetsFileContents
  quickCheck outputsElapsedTime
  putStrLn ""

-- first thing output is the file contents modified with greeting
greetsFileContents :: String -> DiffTime -> DiffTime -> Bool
greetsFileContents p start end = firstOut == greet contents
  where firstOut = result !! 0
        result = runPure hello p [start,end]
        contents = "contents of " ++ p
        greet = ("Hello, " ++)

-- second thing output is elapsed time in ms
outputsElapsedTime :: String -> DiffTime -> DiffTime -> Bool
outputsElapsedTime p start end = secondOut == elapsed
  where secondOut = result !! 1
        result = runPure hello p [start,end]
        elapsed = ( show (truncate ( 1000 * ( end - start ) ) ) ) ++ "ms"

runPure :: Op r -> String -> [DiffTime] -> [String]
runPure (Pure r) _ _ = []
runPure (Free (PutStrLn s t)) arg ts = s:runPure t arg ts
runPure (Free (ReadFile p f)) arg ts  = runPure (f $ "contents of " ++ p) arg ts
runPure (Free (GetTimestamp f)) arg (t:ts) = runPure (f t) arg ts
runPure (Free (GetArgs f)) arg ts = runPure (f [arg]) arg ts
