module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Parsing exposing (Ingredient, asIngredient)
import Parser exposing (..)


full : Test
full =
    test "full" <| \_ ->
        let
            input = "10 tbsp. of butter"
            output = {q=Just 10, unit=Just "tbsp.", rest="of butter"}
        in
            Expect.equal (asIngredient input) output

no_unit : Test
no_unit =
    test "no unit" <| \_ ->
        let
            input = "2 eggs"
            output = {q=Just 2, unit=Nothing, rest="eggs"}
        in
            Expect.equal (asIngredient input) output

floating : Test
floating =
    test "floating" <| \_ ->
        let
            input = "2.5 cups whole milk"
            output = {q=Just 2.5, unit=Just "cups", rest="whole milk"}
        in
            Expect.equal (asIngredient input) output

no_space : Test
no_space =
    test "no space" <| \_ ->
        let
            input = "20tablespoons vanilla extract  "
            output = {q=Just 20, unit=Just "tablespoons", rest="vanilla extract  "}
        in
            Expect.equal (asIngredient input) output

no_trailing : Test --Should we allow this? Doesn't seem like it could be valid recipe.
no_trailing =
    test "no trailing" <| \_ ->
        let
            input = "10.2 litres"
            output = {q=Just 10.2, unit=Just "litres", rest=""}
        in
            Expect.equal (asIngredient input) output

no_number : Test
no_number =
    test "no number" <| \_ ->
        let
            input = "some salt"
            output = {q=Nothing, unit=Nothing, rest="some salt"}
        in
            Expect.equal (asIngredient input) output