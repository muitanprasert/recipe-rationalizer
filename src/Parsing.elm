module Parsing exposing (..)

import Parser exposing (..)
import Inflect exposing (pluralize, pascalize)

type alias Ingredient = { q : Maybe Float, unit : Maybe String, rest : String }

abbrevs =
  [ "g"
  , "kg"
  , "L"
  , "mL"
  , "tsp"
  , "tbsp"
  , "fl oz", "fl.oz", "fl. oz"
  , "oz"
  , "C"
  , "pt"
  , "qt"
  , "gal"
  , "pn"
  , "dr"
  ]

bases =
  [ "gram"
  , "kilogram"
  , "litre"
  , "millilitre"
  , "teaspoon"
  , "tablespoon"
  , "fluid ounce"
  , "ounce"
  , "cup"
  , "pint"
  , "quart"
  , "gallon"
  , "pinch"
  , "drop" ]

units : List (Parser ())
units = List.concatMap (\b -> [keyword (b++"."), keyword b, keyword (pascalize b)]) abbrevs
     ++ List.concatMap (\b -> [keyword (pluralize b), keyword b]) bases

parseQuantity : Parser (Maybe Float)
parseQuantity =
    oneOf
        [ succeed Just
            |. spaces
            |= float
            |. spaces
        , succeed Nothing
        ]

parseUnit : Parser (Maybe String)
parseUnit =
    oneOf
        [ succeed Just
            |. spaces
            |= (getChompedString <| oneOf units)
            |. spaces
        , succeed Nothing
        ]

parseRest : Parser String
parseRest = 
    getChompedString <| chompWhile (\c -> True)

parseLine : Parser Ingredient 
parseLine =
    succeed Ingredient
      |. spaces
      |= parseQuantity
      |= parseUnit
      |= parseRest

asIngredient : String -> Ingredient
asIngredient str = 
    case (run parseLine str) of
      Err _ -> {q=Nothing, unit=Nothing, rest=""} --no input should ever trigger this
      Ok x -> x