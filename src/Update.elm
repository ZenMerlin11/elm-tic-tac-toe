module Update exposing (..)

import Model exposing (..)


-- UPDATE


type Msg
    = Play PlayerPos
    | Recall Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        Play pos ->
            case model.winner of
                Just player ->
                    model

                Nothing ->
                    let
                        newBoard =
                            getNewBoard model pos
                    in
                        { current = newBoard
                        , history = model.current :: model.history
                        , playerIsX = not model.playerIsX
                        , winner = calculateWinner newBoard
                        }

        Recall play ->
            let
                newBoard =
                    Maybe.withDefault model.current
                        (model.history
                            |> List.filter (\b -> .moveNum b == play)
                            |> List.head
                        )

                newHistory =
                    List.filter (\b -> .moveNum b < play) model.history
            in
                { current = newBoard
                , history = newHistory
                , playerIsX = xIsNext play
                , winner = calculateWinner newBoard
                }


getNewBoard : Model -> PlayerPos -> Board
getNewBoard model pos =
    let
        currentBoard =
            model.current
    in
        if pos == 1 then
            { currentBoard
                | pos1 = getPlayer model
                , moveNum = model.current.moveNum + 1
            }
        else if pos == 2 then
            { currentBoard
                | pos2 = getPlayer model
                , moveNum = model.current.moveNum + 1
            }
        else if pos == 3 then
            { currentBoard
                | pos3 = getPlayer model
                , moveNum = model.current.moveNum + 1
            }
        else if pos == 4 then
            { currentBoard
                | pos4 = getPlayer model
                , moveNum = model.current.moveNum + 1
            }
        else if pos == 5 then
            { currentBoard
                | pos5 = getPlayer model
                , moveNum = model.current.moveNum + 1
            }
        else if pos == 6 then
            { currentBoard
                | pos6 = getPlayer model
                , moveNum = model.current.moveNum + 1
            }
        else if pos == 7 then
            { currentBoard
                | pos7 = getPlayer model
                , moveNum = model.current.moveNum + 1
            }
        else if pos == 8 then
            { currentBoard
                | pos8 = getPlayer model
                , moveNum = model.current.moveNum + 1
            }
        else if pos == 9 then
            { currentBoard
                | pos9 = getPlayer model
                , moveNum = model.current.moveNum + 1
            }
        else
            currentBoard


getPlayer : Model -> Maybe Player
getPlayer model =
    if model.playerIsX then
        xPlayer
    else
        oPlayer


calculateWinner : Board -> Maybe Player
calculateWinner bd =
    let
        a =
            bd.pos1

        b =
            bd.pos2

        c =
            bd.pos3

        d =
            bd.pos4

        e =
            bd.pos5

        f =
            bd.pos6

        g =
            bd.pos7

        h =
            bd.pos8

        i =
            bd.pos9
    in
        if squaresEqual a b c then
            a
        else if squaresEqual d e f then
            d
        else if squaresEqual g h i then
            g
        else if squaresEqual a d g then
            a
        else if squaresEqual b e h then
            b
        else if squaresEqual c f i then
            c
        else if squaresEqual a e i then
            a
        else if squaresEqual c e g then
            c
        else
            Nothing


squaresEqual : Maybe Player -> Maybe Player -> Maybe Player -> Bool
squaresEqual a b c =
    if a == Nothing || b == Nothing || c == Nothing then
        False
    else
        a == b && b == c


xIsNext : Int -> Bool
xIsNext moveNum =
    rem moveNum 2 == 0
