module Op (
    Op
  , OpF (PutStrLn, ReadFile, GetPOSIXTime)
  , putStrLn'
  , readFile'
  , getPOSIXTime'
) where

import Control.Monad.Free
import Data.Time.Clock.POSIX

data OpF x
    = PutStrLn String x
    | ReadFile FilePath (String -> x)
    | GetPOSIXTime (POSIXTime -> x)

instance Functor OpF where
  fmap f (PutStrLn s x) = PutStrLn s (f x)
  fmap f (ReadFile p k) = ReadFile p (f . k)
  fmap f (GetPOSIXTime k) = GetPOSIXTime (f . k)

type Op = Free OpF

putStrLn' :: String -> Op ()
putStrLn' s = liftF $ PutStrLn s ()

readFile' :: FilePath -> Op String
readFile' p = liftF $ ReadFile p id

getPOSIXTime' :: Op POSIXTime
getPOSIXTime' = liftF $ GetPOSIXTime id
