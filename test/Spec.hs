import Hello
import Op
import Control.Monad.Free
import Test.QuickCheck

main :: IO ()
main = quickCheck greetsFileContents

-- hello is equivalent to copying a string from one place to another
-- (not really but want to checkpoint and refine this)
greetsFileContents :: String -> Bool
greetsFileContents p = runPure (hello p) == ["hello, contents of " ++ p]


runPure :: Op r -> [String]
runPure (Pure r) = []
runPure (Free (PutStrLn s t)) = s:runPure t
runPure (Free (ReadFile p f)) = runPure (f $ "contents of " ++ p)
