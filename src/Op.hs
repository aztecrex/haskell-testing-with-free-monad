module Op (
    Op
  , OpF (PutStrLn, ReadFile, GetTimestamp, GetArgs)
  , putStrLn'
  , readFile'
  , getTimestamp'
  , getArgs'
) where

import Control.Monad.Free
import Data.Time.Clock

data OpF x
    = PutStrLn String x
    | ReadFile FilePath (String -> x)
    | GetTimestamp (DiffTime -> x)
    | GetArgs ([String] -> x)

instance Functor OpF where
  fmap f (PutStrLn s x) = PutStrLn s (f x)
  fmap f (ReadFile p k) = ReadFile p (f . k)
  fmap f (GetTimestamp k) = GetTimestamp (f . k)
  fmap f (GetArgs k) = GetArgs (f . k)

type Op = Free OpF

putStrLn' :: String -> Op ()
putStrLn' s = liftF $ PutStrLn s ()

readFile' :: FilePath -> Op String
readFile' p = liftF $ ReadFile p id

getTimestamp' :: Op DiffTime
getTimestamp' = liftF $ GetTimestamp id

getArgs' :: Op [String]
getArgs' = liftF $ GetArgs id
