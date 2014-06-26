
$ ->
  WinningTileValue = 16

  buildBoard = ->
    [0..3].map -> [0..3].map -> 0

  @board = buildBoard()

  showBoard = (board) ->
    for x in [0..3]
      for y in [0..3]
        if (board[x][y]) != 0
          $(".r#{x}.c#{y} > div").html(board[x][y])
        else
          $(".r#{x}.c#{y} > div").html(' ')

  showBoard(@board)

  ppArray = (array) ->
    for row in array
      console.log row

  getRow = (row, board) ->
    [r,b] = [row, board]
    [b[r][0], b[r][1], b[r][2], b[r][3]]
  # didn't work previously because didnt create an array

  getColumn = (cNumber, board) ->
    b = board
    c = cNumber
    [b[0][c], b[1][c], b[2][c], b[3][c]]
  # console.log getColumn(2, @board)

  setRow = (row, rowNumber, board) ->
    board[rowNumber] = row

  setColumn = (newArray, cNumber, board) ->
    b = board
    c = cNumber
    [b[0][c], b[1][c], b[2][c], b[3][c]] = newArray


  # getColumnV2 = (columnNumber, board) ->
  #   column = []
  #   for row in [0..3]
  #     column.push board[row][columnNumber]
  #   column

  # getColumnV3 = (c, b) ->
  #   col = []
  #   for r, i in b
  #     col[i] = r[c]
  #   col



  randomInt = (x) ->
    Math.floor(Math.random() * x)

  getRandomCell = ->
    [randomInt(4), randomInt(4)]

  randomValue = ->
    values = [2, 2, 2, 4]
    val = values[randomInt(values.length)]

  arrayEqual = (a, b) ->
    for val, i in a
      if val != b[i]
        return false
    true

  boardEqual = (a, b) ->
    for row, i in a
      unless arrayEqual(row, b[i])
        return false
    true

  moveIsValid = (a, b) ->
    not boardEqual(a,b)

  noValidMoves = (board) ->
    directions = ['up', 'down', 'left', 'right']

    for direction in directions
      newBoard = move(board, direction)
      return false if moveIsValid(newBoard, board)
    true

  gameWon = (board) ->
    for row in board
      for cell in row
        if cell >= WinningTileValue
          return true
    false

  gameLost = (board) ->
    boardFull(board) and noValidMoves(board)

  boardFull = (board) ->
    for x in [0..3]
      for y in [0..3]
        if board[x][y] == 0
          return false
    true

  generateTile = (board) ->
   unless boardFull(board)
    val = randomValue()
    [x, y] = getRandomCell()
    if board[x][y] == 0
      board[x][y] = val
    else
      generateTile(board)

  move = (board, direction) ->

    newBoard = buildBoard()

    switch direction
      when 'left'
        for i in [0..3]
          row = getRow(i, board)
          row = mergeCells(row, 'left')
          row = collapseCells(row, 'left')
          setRow(row, i, newBoard)
      when 'right'
        for i in [0..3]
          row = getRow(i, board)
          row = mergeCells(row, 'right')
          row = collapseCells(row, 'right')
          setRow(row, i, newBoard)
      when 'up'
        for i in [0..3]
          c = getColumn(i, board)
          c = mergeCells(c, 'up')
          c = collapseCells(c, 'up')
          setColumn(c, i, newBoard)
      when 'down'
        for i in [0..3]
          c = getColumn(i, board)
          c = mergeCells(c, 'down')
          c = collapseCells(c, 'down')
          setColumn(c, i, newBoard)

    newBoard

  $('body').keydown (e) =>
    key = e.which
    keys = [37..40]

    if $.inArray(key, keys) > -1
      e.preventDefault()

    direction = switch key
      when 37 then 'left'
      when 38 then 'up'
      when 39 then 'right'
      when 40 then 'down'

    newBoard = move(@board, direction)

    isValid = moveIsValid(newBoard, @board)
    console.log "isValid: " + isValid

    if isValid
      console.log "mmm"
      @board = newBoard
      generateTile(@board)
      showBoard(@board)
      if gameWon(@board)
        console.log "Congrats!"
      else if gameLost(@board)
        console.log "Game Over!"



  mergeCells = (originalCells, direction) ->
    cells = originalCells
    switch direction
      when 'left', 'up'
        for x in [0...3]
          for y in [x+1..3]
            if cells[x] == 0
              break
            else if cells[x] == cells[y]
              cells[x] *= 2
              cells[y] = 0
              break
            else if cells[y] != 0
              break

      when 'right', 'down'
        for x in [3...0]
          for y in [x-1..0]
            if cells[x] == 0
              break
            else if cells[x] == cells[y]
              cells[x] *= 2
              cells[y] = 0
              break
            else if cells[y] != 0
              break
    cells

  # console.log "merging right: " + mergeCells([2, 0, 2, 2], 'right') #=> 2,0,0,4
  # console.log "merging left : " + mergeCells([2, 0, 4, 2], 'left') #=> 4,0,0,2

  collapseCells = (originalCells, direction) ->
    cells = originalCells

    countZero = (array) ->
      count = 0
      for x in array
        if x == 0
          count = count + 1
      count
    console.log "counting 0's: " + countZero([0, 2, 2, 0])

    count = countZero(originalCells)

    for i in [0...count]
      switch direction
        when 'left', 'up'
          for x in [0...3]
            temp = cells[x]
            if cells[x] == 0
              cells[x] = cells[x+1]
              cells[x+1] = temp

        when 'right', 'down'
          for x in [3...0]
            temp = cells[x]
            if cells[x] == 0
              cells[x] = cells[x-1]
              cells[x-1] = temp
    cells

  generateTile(@board)
  generateTile(@board)
  showBoard(@board)















