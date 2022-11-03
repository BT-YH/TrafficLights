enum States {
  none('-'),
  g('G'),
  y('Y'),
  r('R');

  final String str;

  const States(this.str);

  @override
  String toString() => str;
}

class TrafficLightsState{
  static const row = 4;
  static const col = 3;
  static const numCells = row * col;
  static const lines = [
    // rows
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [9, 10, 11],
    // columns
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [4, 7, 10],
    [5, 8, 11],
    // diagonals
    [0, 4, 8],
    [2, 4, 6],
    [3, 7, 11],
    [5, 7, 9]
  ];

  late List<States> board;
  late int currentPlayer, winner;
  late int turn;

  TrafficLightsState() {
    reset();
  }

  void reset() {
    board = List.filled(numCells, States.none);
    currentPlayer = 0; // P1 = 0; P2 = 1
    winner = -1;
    turn = 0;
  }

  bool playAt(int i) {
    if (winner == -1 && board[i] != States.r) {
      if (board[i] == States.none) {
        board[i] = States.g;
        _checkWinner(currentPlayer);
        currentPlayer = (currentPlayer == 0) ? 1 : 0;
        turn++;
        return true;
      } else if (board[i] == States.g) {
        board[i] = States.y;
        _checkWinner(currentPlayer);
        currentPlayer = (currentPlayer == 0) ? 1 : 0;
        turn++;
        return true;
      } else if (board[i] == States.y) {
        board[i] = States.r;
        _checkWinner(currentPlayer);
        currentPlayer = (currentPlayer == 0) ? 1 : 0;
        turn++;
        return true;
      }
    }
    return false;
  }

  void _checkWinner(int currentPlayer) {
    for (List<int> line in lines) {
      if (board[line[0]] != States.none &&
          board[line[0]] == board[line[1]] &&
          board[line[1]] == board[line[2]]) {
        winner = currentPlayer;
        return;
      }
    }
  }

  int getWinner() => winner;

  bool isGameOver() => (winner != -1);

  String getStatus() {
    if (isGameOver()) {
      return 'P${winner + 1} wins!';
    } else {
      return 'P${currentPlayer + 1} to play.';
    }
  }

  @override
  String toString() {
    var sb = StringBuffer();
    for (int i = 0; i < board.length; i++) {
      sb.write(board[i].toString());
      if (i % col == col - 1) {
        sb.writeln(); // change line
      }
    }
    sb.writeln('\n${getStatus()}');
    return sb.toString();
  }
}


