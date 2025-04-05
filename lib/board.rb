# frozen_string_literal: true

require 'colorize'

# Board for colored pieces
class Board
  attr_reader :board_indices

  attr_accessor :board, :last_move_index

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

  def check_win?
    win_directions = %i[horizontal vertical botRight_to_upLeft botLeft_to_upRight]

    win_directions.each do |orientation|
      return true if match?(orientation)
    end

    false
  end

  def space_available?(letter)
    index = @board_indices[letter]

    board[0][index].nil?
  end

  private

  def match?(orientation)
    points = 0
    color = @board[@last_move_index[0]][@last_move_index[1]]
    to_add = add_to_index(orientation)
    a = to_add[0]
    b = to_add[1]

    points += tally_points(color, a, b)
    points += tally_points(color, -a, -b)

    points -= 1
    points == 4
  end

  def tally_points(color, add_a, add_b)
    index_one = @last_move_index[0]
    index_two = @last_move_index[1]
    points = 0

    until index_two.negative? || @board[index_one].nil? || @board[index_one][index_two] != color

      index_one += add_a
      index_two += add_b
      points += 1
    end

    points
  end

  def add_to_index(orientation)
    a = 0
    b = 0
    case orientation
    when :horizontal
      b = 1
    when :vertical
      a = 1
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
          print '| '
          print 'X'.green
          print ' |'
        else
          print '| '
          print '⚉'.send(slot)
          print ' |'
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
