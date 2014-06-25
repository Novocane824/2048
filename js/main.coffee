
$ ->
  ppArray = (array) ->
    for row in array
      console.log row

  # a1 = [0..3]
  # a2 = [4..7]
  # a3 = [8..11]
  # a4 = [12..15]

  # masterArray = ->
  #   masterArray = [a1, a2, a3, a4]
  # masterArray()

  @board = [0..3].map -> [0..3].map -> 0

  for x in [0..3]
    @board[x] = []
    for y in [0..3]
      @board[x][y] = 0

  randomInt = (x) ->
    Math.floor(Math.random() * x)

  getRandomCell = ->
    [randomInt(4), randomInt(4)]

  randomValue = ->
    values = [2, 2, 2, 4]
    val = values[randomInt(values.length)]

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
  console.log generateTile(@board)

  $('body').keydown (e) ->
    key = e.which
    keys = [37..40]

    if $.inArray(key, keys) > -1
      e.preventDefault()

    switch key
      when 37
        console.log 'left'
      when 38
        console.log 'up'
      when 39
        console.log 'right'
      when 40
        console.log 'down'

  generateTile(@board)
  ppArray(@board)

  getRow = (r, board) ->
    board[r]
  # console.log getRow(1, @board)

  getColumn = (c, board) ->
    b = board
    [b[0][c], b[1][c], b[2][c], b[3][c]]
  # console.log getColumn(2, @board)

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

  console.log "merging right: " + mergeCells([2, 0, 2, 2], 'right') #=> 2,0,0,4
  console.log "merging left : " + mergeCells([2, 0, 4, 2], 'left') #=> 4,0,0,2

  collapseCells = (originalCells, direction) ->
    countZero = (array) ->
      count = 0
      for x in array
        if x == 0
          count = count + 1
      count
    console.log "counting 0's: " + countZero([0, 0, 0, 4])

    count = countZero(originalCells)

    for i in [0...count]
      cells = originalCells
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

  console.log "collapsing: " + collapseCells([2, 0, 2, 2], 'right')
  console.log "collapsing: " + collapseCells([2, 0, 2, 4], 'left')
  console.log "collapsing: " + collapseCells([2, 4, 0, 4], 'left')
  console.log "collapsing: " + collapseCells([0, 0, 0, 4], 'left')


  cells = [2, 0, 2, 4]
  # 1. merge
  result = mergeCells(cells)
  @board
  # 2. collapse
  collapseCells(cells)















