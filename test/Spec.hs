import Hello
import Op
import Control.Monad.Free
import Test.QuickCheck

main :: IO ()
main = do
  print $ runPure $ hello "hi"
  quickCheck greetsFileContents
  quickCheck outputsElapsedTime

-- first thing output is the file contents modified with greeting
greetsFileContents :: String -> Bool
greetsFileContents p = firstOut == greet contents
  where firstOut = runPure (hello p) !! 0
        contents = "contents of " ++ p
        greet = ("Hello, " ++)

outputsElapsedTime :: String -> Bool
outputsElapsedTime p = secondOut == elapsed
  where secondOut = runPure (hello p) !! 1
        elapsed = "0s"

runPure :: Op r -> [String]
runPure (Pure r) = []
runPure (Free (PutStrLn s t)) = s:runPure t
runPure (Free (ReadFile p f)) = runPure (f $ "contents of " ++ p)
runPure (Free (GetPOSIXTime f)) = runPure (f 100000000000)
