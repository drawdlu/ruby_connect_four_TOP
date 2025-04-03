# frozen_string_literal: true

# Board for colored pieces
class Board
  attr_reader :board_indices, :board

  def initialize
    @board = Array.new(6) { Array.new(7, nil) }
    @board_indices = { A: 0, B: 1, C: 2, D: 3, E: 4, F: 5, G: 6 }.freeze
  end

  def place_piece_on_board(color, letter)
    index_one = @board_indices[letter]
    index_two = 5 # last index of a row

    index_two -= 1 until @board[index_one][index_two].nil?

    @board[index_one][index_two] = color
  end
end
