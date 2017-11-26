class Player
  attr_accessor :name
  attr_accessor :symbol

  def check_winner(game_grid)
    winner = false
    arr = game_grid
    3.times do |x|
      if arr[3*x] == @symbol && arr[3*x+1] == @symbol && arr[3*x+2] == @symbol ||
        arr[x] == @symbol && arr[x+3] == @symbol && arr[x+6] == @symbol
        winner = true
      end
    end
    if arr[4] == @symbol
      if arr[0] == @symbol && arr[8] == @symbol ||
        arr[2] == @symbol && arr[6] == @symbol
        winner = true
      end
    end
    if winner
      system "clear"
      print_grid(arr)
      puts "#{@name}, you are the winner!"
      gets.chomp
    end
    winner
  end
end

def print_grid(game_grid)
  puts "\n"
  game_grid.each_with_index do |element, index|
    print " #{element} "
    next if index == 8
    if index != 2 && index != 5
      print "|"
    else
      puts "\n-----------"
    end
  end
  puts "\n\n"
end

player_1 = Player.new
player_2 = Player.new

puts "Enter player 1's name: "
player_1.name = gets.chomp
puts "\nEnter player 2's name: "
player_2.name = gets.chomp

puts "\n#{player_1.name} choose your symbol: 'X' or 'O'"
player_1.symbol = gets.chomp.upcase
if player_1.symbol == "X"
  player_2.symbol = "O"
else
  player_2.symbol = "X"
end

game_grid = (1..9).to_a

puts "You can select which quadrant to place your symbol by pressing one of the number keys with the corresponding quadrant\n\n"
print_grid(game_grid)
puts "\nPress any key when you are ready..."
gets.chomp

winner = false
player_1_turn = true
while(!winner)
  system "clear"
  if player_1_turn
    current_player = player_1
  else
    current_player = player_2
  end
  puts "#{current_player.name}, it is your turn to place your symbol '#{current_player.symbol}'"
  print_grid(game_grid)
  begin
    print "Please enter the number you would like to place your symbol in: "
    input = gets.chomp
    game_grid[game_grid.index(input.to_i)] = current_player.symbol
  rescue
    puts "\nThat is not a valid input. Press any key to try again."
    gets.chomp
  else
    winner = current_player.check_winner(game_grid)
    player_1_turn = !player_1_turn
  end
end
