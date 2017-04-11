module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }



-- MODEL


type Player
    = X
    | O


type alias Board =
    { pos1 : Maybe Player
    , pos2 : Maybe Player
    , pos3 : Maybe Player
    , pos4 : Maybe Player
    , pos5 : Maybe Player
    , pos6 : Maybe Player
    , pos7 : Maybe Player
    , pos8 : Maybe Player
    , pos9 : Maybe Player
    , moveNum : Int
    }


type alias Model =
    { current : Board
    , history : List Board
    , nextPlayer : Player
    , winner : Maybe Player
    }


initBoard : Board
initBoard =
    { pos1 = Nothing
    , pos2 = Nothing
    , pos3 = Nothing
    , pos4 = Nothing
    , pos5 = Nothing
    , pos6 = Nothing
    , pos7 = Nothing
    , pos8 = Nothing
    , pos9 = Nothing
    , moveNum = 0
    }


initModel : Model
initModel =
    { current = initBoard
    , history = []
    , nextPlayer = X
    , winner = Nothing
    }



-- UPDATE


type Msg
    = Play Int
    | Recall Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        Play square ->
            model

        Recall play ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "game" ]
        [ p [] [ text "Game goes here" ]
        ]
