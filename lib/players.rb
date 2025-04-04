# frozen_string_literal: true

# for player data

class Players
  attr_reader :player1, :player2

  def initialize
    player_name1 = get_name(1)
    player_name2 = get_name(2)

    @player1 = { player_name1 => :red }
    @player2 = { player_name2 => :blue }
  end

  def get_name(player_num)
    length = 0
    while length < 1
      print "Enter player #{player_num} name: "
      name = gets.chomp
      length = name.length
    end
    name
  end
end
