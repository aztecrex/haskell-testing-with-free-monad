module Main where

import Hello
import OpIO

main :: IO ()
main = run $ hello "/etc/group"
