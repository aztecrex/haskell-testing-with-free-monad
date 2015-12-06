import Hello
import Op
import Control.Monad.Free
import Test.QuickCheck

main :: IO ()
main = quickCheck propCopiesFileOut

-- hello is equivalent to copying a string from one place to another
-- (not really but want to checkpoint and refine this)
propCopiesFileOut :: String -> Bool
propCopiesFileOut s = runPure (hello "/whatever") [s] == [s]


runPure :: Op r -> [String] -> [String]
runPure (Pure r) xs = []
runPure (Free (PutStrLn s t)) ss = s:runPure t ss
runPure (Free (ReadFile p f)) (s:ss) = runPure (f s) ss
