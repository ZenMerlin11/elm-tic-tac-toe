module View exposing (..)

import Model exposing (..)
import Update exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- VIEW


view : Model -> Html Msg
view model =
    div [ class "game" ]
        [ board model
        , div [ class "game-info" ]
            [ status model
            , movesList model
            ]
        ]


board : Model -> Html Msg
board model =
    div [ class "board" ]
        [ div [ class "board-row" ]
            [ square model.current.pos1 1
            , square model.current.pos2 2
            , square model.current.pos3 3
            ]
        , div [ class "board-row" ]
            [ square model.current.pos4 4
            , square model.current.pos5 5
            , square model.current.pos6 6
            ]
        , div [ class "board-row" ]
            [ square model.current.pos7 7
            , square model.current.pos8 8
            , square model.current.pos9 9
            ]
        ]


square : Maybe Player -> PlayerPos -> Html Msg
square player pos =
    case player of
        Just aPlayer ->
            button
                [ class "square" ]
                [ text aPlayer ]

        Nothing ->
            button
                [ class "square"
                , onClick (Play pos)
                ]
                [ text "" ]


status : Model -> Html Msg
status model =
    let
        statusMessage =
            case model.winner of
                Just player ->
                    "Winner: " ++ player

                Nothing ->
                    if model.current.moveNum == 9 then
                        "Winner: Draw"
                    else if model.playerIsX then
                        "Next Player: X"
                    else
                        "Next Player: O"
    in
        div [ class "status" ]
            [ text statusMessage
            ]


movesList : Model -> Html Msg
movesList model =
    model.history
        |> List.sortBy .moveNum
        |> List.map move
        |> ul []


move : Board -> Html Msg
move board =
    li []
        [ a
            [ href "#"
            , onClick (Recall board.moveNum)
            ]
            [ text (getMoveDesc board.moveNum) ]
        ]


getMoveDesc : Int -> String
getMoveDesc moveNum =
    if moveNum == 0 then
        "Game Start"
    else
        "Move #" ++ (toString moveNum)
