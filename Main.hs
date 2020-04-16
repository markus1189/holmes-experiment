{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
module Main where

import Data.Holmes
import GHC.Generics (Generic)
import Data.Hashable (Hashable)

data Value = Red | Green | Blue
  deriving stock (Eq, Ord, Show, Enum, Bounded, Generic)
  deriving anyclass (Hashable)

main :: IO ()
main = do
  result <- australia
  print result

australia :: IO (Maybe [Intersect Value])
australia =
  config `satisfying` \[wa, nt, q, nsw, v, sa, _] ->
    and' [ sa ./= wa
         , sa ./= nt
         , sa ./= q
         , sa ./= nsw
         , sa ./= v
         , wa ./= nt
         , nt ./= q
         , q ./= nsw
         , nsw ./= v
         ]

config :: Config Holmes (Intersect Value)
config = 7 `from` [ minBound..maxBound ]
