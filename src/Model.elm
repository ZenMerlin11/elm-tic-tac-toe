module Model exposing (..)

-- MODEL


type alias Player =
    String


type alias PlayerPos =
    Int


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
    , playerIsX : Bool
    , winner : Maybe Player
    }


xPlayer : Maybe Player
xPlayer =
    Just "X"


oPlayer : Maybe Player
oPlayer =
    Just "O"


noPlayer : Maybe Player
noPlayer =
    Nothing


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
    , playerIsX = True
    , winner = Nothing
    }
