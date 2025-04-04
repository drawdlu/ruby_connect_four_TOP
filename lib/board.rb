# frozen_string_literal: true

# Board for colored pieces
class Board
  attr_reader :board_indices, :board, :last_move_index

  def initialize
    @board = Array.new(6) { Array.new(7, nil) }
    @board_indices = { A: 0, B: 1, C: 2, D: 3, E: 4, F: 5, G: 6 }.freeze
    @last_move_index = nil
  end

  def place_piece_on_board(color, letter)
    index_one = 5 # last index of a row
    index_two = @board_indices[letter]

    index_one -= 1 until @board[index_one][index_two].nil?

    @board[index_one][index_two] = color
    @last_move_index = [index_one, index_two]
  end

  def check_win?(last_index_pair)
    win_directions = %i[horizontal vertical botRight_to_upLeft botLeft_to_upRight]

    win_directions.each do |orientation|
      return true if match?(last_index_pair, orientation)
    end

    false
  end

  def space_available?(letter)
    index = @board_indices[letter]

    board[0][index].nil?
  end

  private

  def match?(last_index_pair, orientation)
    points = 0
    index_one = last_index_pair[0]
    index_two = last_index_pair[1]
    color = @board[index_one][index_two]
    to_add = add_to_index(orientation)
    a = to_add[0]
    b = to_add[1]

    until points == 4 || @board[index_one].nil?
      break unless @board[index_one][index_two] == color

      index_one += a
      index_two += b
      points += 1
    end

    points == 4
  end

  def add_to_index(orientation)
    a = 0
    b = 0
    case orientation
    when :horizontal
      b = -1
    when :vertical
      a = -1
    when :botRight_to_upLeft
      a = 1
      b = 1
    else
      a = 1
      b = -1
    end

    [a, b]
  end

  def to_s
    print_letters
    print_line
    @board.each do |line|
      line.each do |slot|
        if slot.nil?
          print '| X |'
        else
          print "| #{slot} |"
        end
      end
      puts
      print_line
    end
  end

  def print_letters
    puts
    @board_indices.each_key do |key|
      print "  #{key}  "
    end
    puts
  end

  def print_line
    puts '- - - - - - - - - - - - - - - - - -'
  end
end
