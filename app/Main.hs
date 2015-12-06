module Main where

import Hello
import Op
import OpIO

main :: IO ()
main = run $ hello "/etc/group"
