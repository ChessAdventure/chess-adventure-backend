class Fen
  # Credit to github.com/chessquest for initial implementation
  attr_reader :board, :to_move, :castling, :en_passant, :half_moves, :full_moves

  NON_WHITE_BOARD = "rnbqkbnr/pppppppp/8/8/8/8/"
  FULL_WHITE_BOARD = "PPPPPPPP/RNBQKBNR".split('')

  def initialize(fen_string = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', black = false)
    string_fragments = split(fen_string)
    @board = black ? string_fragments[:board].swapcase : string_fragments[:board]
    @to_move = string_fragments[:to_move]
    @castling = string_fragments[:castling]
    @en_passant = string_fragments[:en_passant]
    @half_moves = string_fragments[:half_moves]
    @full_moves = string_fragments[:full_moves]
  end

  def fen
    @board + " " + @to_move + " " + @castling.to_s + ' ' + (@en_passant || '-') + " " + @half_moves + ' ' + @full_moves
  end

  def to_starting_position
    get_starting_board
    check_castling
    @to_move = 'w'
    @half_moves = '0'
    @full_moves = '1'
    self
  end

  private

  def check_castling
    @castling = "QK"[0..(@board.count('R') -3)].reverse + 'kq'
  end

  def get_starting_board
    current_board =  @board[0..-1] # this is to make your life easier
    @board = NON_WHITE_BOARD + white_layout(current_board)
  end

  def white_layout(current_board)
    empty_squares = nil
    new_board = FULL_WHITE_BOARD.map do |char|
      if piece = current_board.slice!(char)
        placement = empty_squares.to_s + piece
        empty_squares = nil
        placement
      else
        empty_squares = empty_squares.to_i + 1
        ''
      end
    end * '' + empty_squares.to_s
    randomize_board(new_board)
  end

  def randomize_board(new_board)
    # new_board is something like "PPPP4/RNBQKBN1"
    pawns = new_board.split('/')[0].split('')
    # pawns is something like ["P", "P", "P", "P", "4"]
    case pawns.length
    when 8, 1
      pawns.shuffle.join
    when 2..7
      num = pawns[-1].to_i
      pawns = (pawns[0..-2] + Array.new(num, '1')).shuffle
      pawns.each_with_object('') do |i, string|
        if i == '1' and (string[-1].to_i > 0)
          string << (string.slice!(-1).to_i + 1).to_s
        else
          string << i
        end
      end
    end + '/' + new_board.split('/')[1]
  end

  def split(fen_string)
    string_pieces = fen_string.split(" ")
  {
      board: string_pieces[0],
      to_move: string_pieces[1],
      castling: string_pieces[2],
      en_passant: string_pieces[3],
      half_moves: string_pieces[4],
      full_moves: string_pieces[5]
    }
  end
end
