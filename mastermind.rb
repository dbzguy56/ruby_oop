$smiley_filled = "\u263b"
$frown = "\u2639"
$circle_filled = "\u25d9"
class String
  @@color = 37
  def colorize(color)
    "\e[#{color}m#{self}\e[0m"
  end

  def random_color
    @@color = rand(31..36)
  end

  def self.color
    @@color
  end

  def black
  colorize(30)
  end

  def red
  colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def cyan
    colorize(36)
  end

  def gray
    colorize(37)
  end
end

def print_game_grid(game_grid, smileys)
  #system "clear"
  puts "\n\n"

  puts "   Column"
  puts "   A B C D"

  12.times do |row|
    print (12-row).to_s + " "
    if row > 2
      print " "
    end
    4.times do |col|
      print $circle_filled.colorize(game_grid[row * 4 + col]) + " "
    end
    4.times do |col|
      if smileys[row * 4 + col] == 37
        print $frown.colorize(37) + " "
      else
        print $smiley_filled.colorize(smileys[row * 4 + col]) + " "
      end
    end
    puts ""
  end
  puts "Turn\nNumber: " + ($turn + 2).to_s + "\n" if $turn != 11
  puts "\nColors: " + "1 ".red + "2 ".green + "3 ".yellow + + "4 ".blue + "5 ".pink + "6 ".cyan
  print "\nPlease select four of the following colors by pressing \nthe corresponding number from above.
Seperate them using by using commas \n(for Column A,B,C,D respectively): "
end

computer_color_picks = []
game_grid = []
smileys = []

48.times do
  game_grid.push(37)
  smileys.push(37)
end

4.times do
  #computer picks 4 random colors
  String.new.random_color
  computer_color_picks.push((String.color).to_i)
end

$turn = 0
winner = false

puts "Welcome to Mastermind!\n\nRules:\n\n1: The goal of mastermind is to guess the secret code
consisting of a series of 4 different colors.\n\n2: Each guess results back in feedback narrowing down
the possibility of the code.\n\n3: A frown means that there is one color that is not in the secret code.
\n4: A red smiley face means that there is one color in the secret code,
but it is not in the right place.
\n5: Finally, a green smiley means that there is one color that is in the secret code and is also in the "+
"right place. You must guess all of the colors to win!"

print_game_grid(game_grid, smileys)

while(!winner)
  if $turn == 12
    computer_color_picks.each_with_index do |element, index|
      case element
      when 31
        computer_color_picks[index] = "Red"
      when 32
        computer_color_picks[index] = "Green"
      when 33
        computer_color_picks[index] = "Yellow"
      when 34
        computer_color_picks[index] = "Blue"
      when 35
        computer_color_picks[index] = "Pink"
      when 36
        computer_color_picks[index] = "Cyan"
      end
    end
    puts "You lose! The colors were: " + computer_color_picks.to_s
    break
  end

  input = gets.chomp.gsub(/\s+/, "").split(",")

  row = 4 * $turn
  game_grid[-1 - row] = input[-1].to_i + 30
  game_grid[-2 - row] = input[-2].to_i + 30
  game_grid[-3 - row] = input[-3].to_i + 30
  game_grid[-4 - row] = input[-4].to_i + 30

  user_picks = [game_grid[-4 - row], game_grid[-3 - row], game_grid[-2 - row], game_grid[-1 - row]]
  count = 0
  4.times do |index|
    if user_picks[index] == computer_color_picks[index]
      smileys[-4 + count - row] = 32
      count += 1
      user_picks[index] = -1 * user_picks[index]
    end
  end
  computer_color_picks.each_with_index do |element, index|
    element_index = user_picks.find_index(element)
    if element_index != nil
      if user_picks[index] != computer_color_picks[index]
        smileys[-4 + count - row] = 31
        count += 1
        user_picks[element_index] = -1 * element
      end
    end
  end
  user_picks.each_with_index do |element, index|
    if element < 0
      user_picks[index] = -1 * element
    end
  end

  print_game_grid(game_grid, smileys)
  #p computer_color_picks

  if game_grid[-4-row] == computer_color_picks[0] && game_grid[-3-row] == computer_color_picks[1] &&
    game_grid[-2-row] == computer_color_picks[2] && game_grid[-1-row] == computer_color_picks[3]
    puts "You win! Yay!"
    winner = true
  end

  $turn += 1
end

gets
