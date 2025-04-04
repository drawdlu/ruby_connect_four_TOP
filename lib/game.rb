# frozen_string_literal: true

require_relative 'board'
require_relative 'players'

class Game
  MAX_MOVES = 42

  def initialize
    @board = Board.new
    @players = Players.new
    @active_player = @players.player1
  end

  def get_move
    loop do
      move = nil

      until !move.nil? && @board.board_indices.key?(move.upcase.to_sym)
        print 'Enter your move: '
        move = gets.chomp
      end

      move_symbol = move.upcase.to_sym

      return move_symbol if @board.space_available?(move_symbol)

      puts 'The slot you chose is already full'
    end
  end
end
