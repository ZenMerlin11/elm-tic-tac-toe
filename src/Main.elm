module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program Never Model Msg
main =
    beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }



-- MODEL


type alias Player =
    String


type alias Square =
    Maybe Player


type alias Board =
    { grid : List Square
    , moveNum : Int
    }


type alias WinningRows =
    List (List Int)


type alias Model =
    { currentBoard : Board
    , history : List Board
    , xIsNext : Bool
    , winner : Maybe Player
    }


xPlayer : Player
xPlayer =
    "X"


oPlayer : Player
oPlayer =
    "O"


topRow : Int
topRow =
    0


midRow : Int
midRow =
    3


bottomRow : Int
bottomRow =
    6


winningRows : WinningRows
winningRows =
    [ [ 0, 1, 2 ]
    , [ 3, 4, 5 ]
    , [ 6, 7, 8 ]
    , [ 0, 3, 6 ]
    , [ 1, 4, 7 ]
    , [ 2, 5, 8 ]
    , [ 0, 4, 8 ]
    , [ 6, 4, 2 ]
    ]


initBoard : Board
initBoard =
    Board (List.repeat 9 Nothing) 0


initModel : Model
initModel =
    Model initBoard [] True Nothing



-- UPDATE


type Msg
    = Play Int
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
                        { currentBoard = newBoard
                        , history = model.currentBoard :: model.history
                        , xIsNext = not model.xIsNext
                        , winner = calculateWinner newBoard
                        }

        Recall moveNum ->
            let
                newBoard =
                    Maybe.withDefault model.currentBoard
                        (model.history
                            |> List.filter (\b -> .moveNum b == moveNum)
                            |> List.head
                        )

                newHistory =
                    List.filter (\b -> .moveNum b < moveNum) model.history
            in
                { currentBoard = newBoard
                , history = newHistory
                , xIsNext = nextPlayerIsX moveNum
                , winner = calculateWinner newBoard
                }


getNewBoard : Model -> Int -> Board
getNewBoard model pos =
    let
        { grid, moveNum } =
            model.currentBoard

        gridHead =
            List.take pos grid

        currSquare =
            [ (getPlayer model) ]

        gridTail =
            List.drop (pos + 1) grid
    in
        Board
            (List.concat
                [ gridHead, currSquare, gridTail ]
            )
            (moveNum + 1)


getPlayer : Model -> Maybe Player
getPlayer model =
    if model.xIsNext then
        Just xPlayer
    else
        Just oPlayer


calculateWinner : Board -> Maybe Player
calculateWinner { grid } =
    List.map (checkRow grid) winningRows
        |> List.filter (\player -> player /= Nothing)
        |> List.head
        |> Maybe.withDefault Nothing


checkRow : List Square -> List Int -> Maybe Player
checkRow grid rowIdxList =
    let
        wholeRow =
            List.map (getPlayerAt grid) rowIdxList

        headOfRow =
            Maybe.withDefault Nothing (List.head wholeRow)

        restOfRow =
            Maybe.withDefault [ Nothing, Nothing ] (List.tail wholeRow)
    in
        List.foldl
            (\player acc ->
                if player == acc then
                    acc
                else
                    Nothing
            )
            headOfRow
            restOfRow


nextPlayerIsX : Int -> Bool
nextPlayerIsX moveNum =
    rem moveNum 2 == 0



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "game" ]
        [ board model.currentBoard.grid
        , div [ class "game-info" ]
            [ status model
            , movesList model
            ]
        ]


board : List Square -> Html Msg
board grid =
    div [ class "board" ]
        [ boardRow grid topRow
        , boardRow grid midRow
        , boardRow grid bottomRow
        ]


boardRow : List Square -> Int -> Html Msg
boardRow grid rowStartIdx =
    let
        rowEndIdx =
            rowStartIdx + 2
    in
        div [ class "board-row" ]
            (List.map
                (square grid)
                (List.range rowStartIdx rowEndIdx)
            )


square : List Square -> Int -> Html Msg
square grid idx =
    let
        player =
            getPlayerAt grid idx
    in
        case player of
            Just aPlayer ->
                button
                    [ class "square" ]
                    [ text aPlayer ]

            Nothing ->
                button
                    [ class "square"
                    , onClick (Play idx)
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
                    if model.currentBoard.moveNum >= 9 then
                        "Winner: Draw"
                    else if model.xIsNext then
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



-- HELPER FUNCTIONS


getPlayerAt : List Square -> Int -> Maybe Player
getPlayerAt grid idx =
    let
        square =
            getAt grid idx
    in
        case square of
            Just player ->
                player

            Nothing ->
                Nothing


getAt : List a -> Int -> Maybe a
getAt list idx =
    if idx < 0 then
        Nothing
    else
        List.drop idx list |> List.head
