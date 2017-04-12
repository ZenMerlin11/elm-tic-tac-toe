module Main exposing (..)

import Model exposing (..)
import Update exposing (..)
import View exposing (..)
import Html exposing (..)


main : Program Never Model Msg
main =
    beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }
