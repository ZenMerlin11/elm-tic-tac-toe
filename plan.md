# Elm Tic-Tac-Toe Roadmap

## Model

TODO: Model's Shape

```
Player
    = X
    | O
```

```
Board =
    { 1 : Maybe Player 
    , 2 : Maybe Player
    , 3 : Maybe Player
    , 4 : Maybe Player
    , 5 : Maybe Player
    , 6 : Maybe Player
    , 7 : Maybe Player
    , 8 : Maybe Player
    , 9 : Maybe Player
    , moveNum : Int
    }
```

```
Model =
    { current : Board
    , history : List Board
    , nextPlayer : Player 
    , winner : Maybe Player
    }
```

## Update
What actions can we perform in our game?

* Move - player places X or O in a square
* Recall - player recalls game to a previous state

## View
What are the logical sections/groupings of our UI?

* game
    * game-Board
        * board-row
            * square (button)
    * game-info
        * game status
        * moves list
