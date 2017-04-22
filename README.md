# Nim-Game-Haskell
Implementation in Haskell of variant of the Game of Nim. It is played on a board comrising five numbered rows of stars, initially set up as follows:

```
1: * * * * * 
2: * * * * 
3: * * * 
4: * * 
5: * 
```

# Rules
Two players then take it in turn to remove one or more stars from the end of a single row. The winner is the player who makes the board empty, that is who removes the final star of stars from the board.

# Example
```
*Main> nim

1: * * * * * 
2: * * * * 
3: * * * 
4: * * 
5: * 

Player 1
Enter a row number: 1
Stars to remove: 5

1: 
2: * * * * 
3: * * * 
4: * * 
5: * 

Player 2
Enter a row number: 4
Stars to remove: 2

1: 
2: * * * * 
3: * * * 
4: 
5: * 

Player 1
Enter a row number: 2
Stars to remove: 4

1: 
2: 
3: * * * 
4: 
5: * 

Player 2
Enter a row number: 3
Stars to remove: 3

1: 
2: 
3: 
4: 
5: * 

Player 1
Enter a row number: 5
Stars to remove: 1

1: 
2: 
3: 
4: 
5: 

Player 1 wins!
```
