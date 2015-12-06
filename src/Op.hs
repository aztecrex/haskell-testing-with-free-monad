module Op (
    Op
  , OpF (PutStrLn, ReadFile)
  , putStrLn'
  , readFile'
) where

import Control.Monad.Free

data OpF x
    = PutStrLn String x
    | ReadFile FilePath (String -> x)

instance Functor OpF where
  fmap f (PutStrLn s x) = PutStrLn s (f x)
  fmap f (ReadFile p k) = ReadFile p (f . k)

type Op = Free OpF

putStrLn' :: String -> Op ()
putStrLn' s = liftF $ PutStrLn s ()

readFile' :: FilePath -> Op String
readFile' p = liftF $ ReadFile p id
