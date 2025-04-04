# frozen_string_literal: true

# for player data

class Players
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
