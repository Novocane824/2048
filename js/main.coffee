
$ ->
  ppArray = (array) ->
    for row in array
      console.log row

  #method 1: array
  # array1 = [0..3]
  # array2 = [4..7]
  # array3 = [8..11]
  # array4 = [12..15]

  # masterArray = ->
  #   x = [array1, array2, array3, array4]
  #   console.log x

  # masterArray()

  @board = [0..3].map -> [0..3].map -> 0
  ppArray(@board)

  # for x in [0..3]
  #   board[x] = []
  #   for y in [0..3]
  #     board[x][y] = 0

  generateTile = (board) ->

  randomInt = ->
    Math.floor(Math.random() * 3)

  randomValue = ->
    values = [2, 2, 2, 4]
    val = values[randomIndex(values.length) * 3]
  console.log values


