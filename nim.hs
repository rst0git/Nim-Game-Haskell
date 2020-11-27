import qualified Data.Sequence as Seq
import qualified Data.Foldable as Fol
import qualified Data.List as List
import Data.Maybe

-- Player type is used to take control of the turns and who wins
data Player = One | Two deriving (Show, Eq)

-- Change player returns the player that is NOT the one passed as argument
change :: Player -> Player
change One = Two
change Two = One

-- Board is an alias for a Sequence of Ints, as they allow us to update single
-- elements in easily.
type Board = Seq.Seq Int

-- This is the initial board structure
initialBoard :: Board
initialBoard = Seq.fromList [5, 4, 3, 2, 1]

-- The move method checks if the a movement can be executed and returns the
-- updated board in case it is possible
move :: Board -> (Int, Int) -> Maybe Board
move board (row, stars)
  | and [(Seq.index board row) >= stars,
          row < 5] = Just (Seq.adjust (\x -> x - stars) row board)
  | otherwise = Nothing

-- The display methods transforms a Board into a nice, enumerated String of
-- asterisks
display :: Board -> String
display board = List.intercalate "\n" (zipWith (++) numbers (stars board))
                where numbers = ["1. ", "2. ", "3. ", "4. ", "5. "]
                      stars board = [(concat . take n) (repeat "* ")
                                    | n <- Fol.toList board]

-- The next methods are the ones that control IO
main :: IO ()
main = nim

-- Main method welcomes the player, displays the initial board and calls the
-- first turn
nim :: IO ()
nim = do putStrLn "Welcome to nim!"
         putStrLn (display initialBoard)
         turn initialBoard One

-- The turn method displays the player and asks for a movement, then checks if
-- there was a problem performing that movement and continues the game. This is
-- the main game loop
turn :: Board -> Player -> IO ()
turn board player = do putStrLn ("\nIt's your turn, Player " ++ (show player) ++ "!")
                       putStrLn "Choose a row to remove stars!"
                       row <- getLine
                       putStrLn "How many stars do you want to remove?"
                       stars <- getLine
                       let newBoard = move board ((read row) - 1, read stars)
                       if newBoard == Nothing
                         then do putStrLn "Not valid movement"
                                 turn board player
                         else isOver (fromJust newBoard) (change player)

-- isOver checks if the Board is empty, and checks whether the game is over or
-- the next turn must be called
isOver :: Board -> Player -> IO()
isOver board player = do if board == Seq.fromList [0, 0, 0, 0, 0]
                           then putStrLn ("Congratulations, Player " ++ (show player)
                                         ++ ", you win!")
                           else do putStrLn ""
                                   putStrLn (display board)
                                   turn board player
