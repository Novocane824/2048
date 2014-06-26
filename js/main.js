// Generated by CoffeeScript 1.7.1
(function() {
  $(function() {
    var WinningTileValue, arrayEqual, boardEqual, boardFull, buildBoard, collapseCells, gameLost, gameWon, generateTile, getColumn, getRandomCell, getRow, mergeCells, move, moveIsValid, noValidMoves, ppArray, randomInt, randomValue, setColumn, setRow, showBoard;
    WinningTileValue = 16;
    buildBoard = function() {
      return [0, 1, 2, 3].map(function() {
        return [0, 1, 2, 3].map(function() {
          return 0;
        });
      });
    };
    this.board = buildBoard();
    showBoard = function(board) {
      var x, y, _i, _results;
      _results = [];
      for (x = _i = 0; _i <= 3; x = ++_i) {
        _results.push((function() {
          var _j, _results1;
          _results1 = [];
          for (y = _j = 0; _j <= 3; y = ++_j) {
            if (board[x][y] !== 0) {
              _results1.push($(".r" + x + ".c" + y + " > div").html(board[x][y]));
            } else {
              _results1.push($(".r" + x + ".c" + y + " > div").html(' '));
            }
          }
          return _results1;
        })());
      }
      return _results;
    };
    showBoard(this.board);
    ppArray = function(array) {
      var row, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = array.length; _i < _len; _i++) {
        row = array[_i];
        _results.push(console.log(row));
      }
      return _results;
    };
    getRow = function(row, board) {
      var b, r, _ref;
      _ref = [row, board], r = _ref[0], b = _ref[1];
      return [b[r][0], b[r][1], b[r][2], b[r][3]];
    };
    getColumn = function(cNumber, board) {
      var b, c;
      b = board;
      c = cNumber;
      return [b[0][c], b[1][c], b[2][c], b[3][c]];
    };
    setRow = function(row, rowNumber, board) {
      return board[rowNumber] = row;
    };
    setColumn = function(newArray, cNumber, board) {
      var b, c;
      b = board;
      c = cNumber;
      return b[0][c] = newArray[0], b[1][c] = newArray[1], b[2][c] = newArray[2], b[3][c] = newArray[3], newArray;
    };
    randomInt = function(x) {
      return Math.floor(Math.random() * x);
    };
    getRandomCell = function() {
      return [randomInt(4), randomInt(4)];
    };
    randomValue = function() {
      var val, values;
      values = [2, 2, 2, 4];
      return val = values[randomInt(values.length)];
    };
    arrayEqual = function(a, b) {
      var i, val, _i, _len;
      for (i = _i = 0, _len = a.length; _i < _len; i = ++_i) {
        val = a[i];
        if (val !== b[i]) {
          return false;
        }
      }
      return true;
    };
    boardEqual = function(a, b) {
      var i, row, _i, _len;
      for (i = _i = 0, _len = a.length; _i < _len; i = ++_i) {
        row = a[i];
        if (!arrayEqual(row, b[i])) {
          return false;
        }
      }
      return true;
    };
    moveIsValid = function(a, b) {
      return !boardEqual(a, b);
    };
    noValidMoves = function(board) {
      var direction, directions, newBoard, _i, _len;
      directions = ['up', 'down', 'left', 'right'];
      for (_i = 0, _len = directions.length; _i < _len; _i++) {
        direction = directions[_i];
        newBoard = move(board, direction);
        if (moveIsValid(newBoard, board)) {
          return false;
        }
      }
      return true;
    };
    gameWon = function(board) {
      var cell, row, _i, _j, _len, _len1;
      for (_i = 0, _len = board.length; _i < _len; _i++) {
        row = board[_i];
        for (_j = 0, _len1 = row.length; _j < _len1; _j++) {
          cell = row[_j];
          if (cell >= WinningTileValue) {
            return true;
          }
        }
      }
      return false;
    };
    gameLost = function(board) {
      return boardFull(board) && noValidMoves(board);
    };
    boardFull = function(board) {
      var x, y, _i, _j;
      for (x = _i = 0; _i <= 3; x = ++_i) {
        for (y = _j = 0; _j <= 3; y = ++_j) {
          if (board[x][y] === 0) {
            return false;
          }
        }
      }
      return true;
    };
    generateTile = function(board) {
      var val, x, y, _ref;
      if (!boardFull(board)) {
        val = randomValue();
        _ref = getRandomCell(), x = _ref[0], y = _ref[1];
        if (board[x][y] === 0) {
          return board[x][y] = val;
        } else {
          return generateTile(board);
        }
      }
    };
    move = function(board, direction) {
      var c, i, newBoard, row, _i, _j, _k, _l;
      newBoard = buildBoard();
      switch (direction) {
        case 'left':
          for (i = _i = 0; _i <= 3; i = ++_i) {
            row = getRow(i, board);
            row = mergeCells(row, 'left');
            row = collapseCells(row, 'left');
            setRow(row, i, newBoard);
          }
          break;
        case 'right':
          for (i = _j = 0; _j <= 3; i = ++_j) {
            row = getRow(i, board);
            row = mergeCells(row, 'right');
            row = collapseCells(row, 'right');
            setRow(row, i, newBoard);
          }
          break;
        case 'up':
          for (i = _k = 0; _k <= 3; i = ++_k) {
            c = getColumn(i, board);
            c = mergeCells(c, 'up');
            c = collapseCells(c, 'up');
            setColumn(c, i, newBoard);
          }
          break;
        case 'down':
          for (i = _l = 0; _l <= 3; i = ++_l) {
            c = getColumn(i, board);
            c = mergeCells(c, 'down');
            c = collapseCells(c, 'down');
            setColumn(c, i, newBoard);
          }
      }
      return newBoard;
    };
    $('body').keydown((function(_this) {
      return function(e) {
        var direction, isValid, key, keys, newBoard;
        key = e.which;
        keys = [37, 38, 39, 40];
        if ($.inArray(key, keys) > -1) {
          e.preventDefault();
        }
        direction = (function() {
          switch (key) {
            case 37:
              return 'left';
            case 38:
              return 'up';
            case 39:
              return 'right';
            case 40:
              return 'down';
          }
        })();
        newBoard = move(_this.board, direction);
        isValid = moveIsValid(newBoard, _this.board);
        console.log("isValid: " + isValid);
        if (isValid) {
          console.log("mmm");
          _this.board = newBoard;
          generateTile(_this.board);
          showBoard(_this.board);
          if (gameWon(_this.board)) {
            return console.log("Congrats!");
          } else if (gameLost(_this.board)) {
            return console.log("Game Over!");
          }
        }
      };
    })(this));
    mergeCells = function(originalCells, direction) {
      var cells, x, y, _i, _j, _k, _l, _ref, _ref1;
      cells = originalCells;
      switch (direction) {
        case 'left':
        case 'up':
          for (x = _i = 0; _i < 3; x = ++_i) {
            for (y = _j = _ref = x + 1; _ref <= 3 ? _j <= 3 : _j >= 3; y = _ref <= 3 ? ++_j : --_j) {
              if (cells[x] === 0) {
                break;
              } else if (cells[x] === cells[y]) {
                cells[x] *= 2;
                cells[y] = 0;
                break;
              } else if (cells[y] !== 0) {
                break;
              }
            }
          }
          break;
        case 'right':
        case 'down':
          for (x = _k = 3; _k > 0; x = --_k) {
            for (y = _l = _ref1 = x - 1; _ref1 <= 0 ? _l <= 0 : _l >= 0; y = _ref1 <= 0 ? ++_l : --_l) {
              if (cells[x] === 0) {
                break;
              } else if (cells[x] === cells[y]) {
                cells[x] *= 2;
                cells[y] = 0;
                break;
              } else if (cells[y] !== 0) {
                break;
              }
            }
          }
      }
      return cells;
    };
    collapseCells = function(originalCells, direction) {
      var cells, count, countZero, i, temp, x, _i, _j, _k;
      cells = originalCells;
      countZero = function(array) {
        var count, x, _i, _len;
        count = 0;
        for (_i = 0, _len = array.length; _i < _len; _i++) {
          x = array[_i];
          if (x === 0) {
            count = count + 1;
          }
        }
        return count;
      };
      console.log("counting 0's: " + countZero([0, 2, 2, 0]));
      count = countZero(originalCells);
      for (i = _i = 0; 0 <= count ? _i < count : _i > count; i = 0 <= count ? ++_i : --_i) {
        switch (direction) {
          case 'left':
          case 'up':
            for (x = _j = 0; _j < 3; x = ++_j) {
              temp = cells[x];
              if (cells[x] === 0) {
                cells[x] = cells[x + 1];
                cells[x + 1] = temp;
              }
            }
            break;
          case 'right':
          case 'down':
            for (x = _k = 3; _k > 0; x = --_k) {
              temp = cells[x];
              if (cells[x] === 0) {
                cells[x] = cells[x - 1];
                cells[x - 1] = temp;
              }
            }
        }
      }
      return cells;
    };
    generateTile(this.board);
    generateTile(this.board);
    return showBoard(this.board);
  });

}).call(this);

//# sourceMappingURL=main.map
