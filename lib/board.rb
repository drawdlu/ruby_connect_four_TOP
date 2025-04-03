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

  def check_win?(last_index_pair)
    win_directions = %i[horizontal vertical]

    win_directions.each do |orientation|
      return true if match?(last_index_pair, orientation)
    end

    false
  end

  def match?(last_index_pair, orientation)
    points = 0
    index_one = last_index_pair[0]
    index_two = last_index_pair[1]
    color = @board[last_index_pair[0]][last_index_pair[1]]

    until points == 4
      break unless @board[index_one][index_two] == color

      points += 1
      if orientation == :horizontal
        index_two -= 1
      elsif orientation == :Vertical
        index_one -= 1
      end
    end

    points == 4
  end
end
