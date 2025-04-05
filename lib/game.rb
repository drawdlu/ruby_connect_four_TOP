# frozen_string_literal: true

require_relative 'board'
require_relative 'players'

# handles game loop
class Game
  MAX_MOVES = 42

  def initialize
    @board = Board.new
    @players = Players.new
    @active_player = @players.player1
  end

  def start
    MAX_MOVES.times do
      puts @board
      move = get_move
      @board.place_piece_on_board(@active_player.values[0], move)
      if @board.check_win?
        puts @board
        announce_winner
        return
      end

      @active_player = @active_player == @players.player1 ? @players.player2 : @players.player1
    end

    announce_draw
  end

  def get_move
    loop do
      move = nil
      name = @active_player.keys[0]

      until !move.nil? && @board.board_indices.key?(move.upcase.to_sym)
        puts
        print "#{name}'s turn to pick: "
        move = gets.chomp
      end

      move_symbol = move.upcase.to_sym

      return move_symbol if @board.space_available?(move_symbol)

      puts 'The slot you chose is already full'
      puts
    end
  end

  private

  def announce_winner
    puts
    puts "#{@active_player.keys[0]} HAS WON THE GAME!"
    puts
  end

  def announce_draw
    puts
    puts 'THE GAME HAS ENDED IN A DRAW'
    puts
  end
end
