grid = Array.new(8){Array.new(8){"-"}}
(0..7).each do |i|
  (0..7).each do |j|
    print grid[i][j]
  end
  puts
end
puts
ships = Array.new(8){Array.new(8){"-"}}
#These are for the raft
ships[2][3]="X"
# ships[2][4]="X"
# raft=false
# #These are for the gondola
# ships[5][7]="X"
# ships[6][7]="X"
# ships[7][7]="X"
# gondola=false
# #These are for the MasterPaddleBoat
# ships[5][4]="X"
# ships[5][3]="X"
# ships[5][2]="X"
# ships[5][1]="X"
# masterpaddleboat=false

(0..7).each do |i|
  (0..7).each do |j|
    print ships[i][j]
  end
  puts
end
hits=0
(0..7).each do |i|
  (0..7).each do |j|
    if ships[i][j]=="X"
      hits+=1
  end
end


loops=true
asking=true
checking=true
while loops
  while asking
  puts "Please input a row (1-8): "
  rows=gets.to_i-1
  if rows>=0&&rows<8
    asking=false
    while checking
      puts "Please input a column(1-8): "
      cols=gets.to_i-1
      if cols>=0&&cols<8
        checking=false
        if ships[rows][cols]=="X"
          hits=hits-1
          puts "You got a hit!"
          grid[rows][cols]="X"
          if grid[2][3]=="X"&&grid[2][4]=="X"&&raft==false
            raft=true
            puts "You sunk the Raft!"
          end
          if grid[5][7]=="X"&&grid[6][7]=="X"&&grid[7][7]=="X"&& gondola==false
            gondola=true
            puts "You sunk the Gondola"
          end
          if grid[5][4]=="X"&&grid[5][3]=="X"&&grid[5][2]=="X"&&grid[5][1]=="X"&& gondola==false
            masterpaddleboat=true
            puts "You sunk the Master Paddle Boat"
          end
        else
          if ships[rows-1][cols-1]=="X"||ships[rows-1][cols+1]=="X"||ships[rows+1][cols-1]=="X"||ships[rows-1][cols]=="X"||ships[rows][cols-1]=="X"||ships[rows+1][cols+1]=="X"||ships[rows][cols+1]=="X"||ships[rows+1][cols]=="X"
            puts "You missed, but you were close!!"
            grid[rows][cols]="0"
          else
          puts "You missed!"
          grid[rows][cols]="0"
        end
      end
    end
  end
end
if hits==0
  puts "You won.\nYou destroyed my fleet!\n\n\t...\n\n\tCongrats...I guess."
  loops=false
else
  puts "Would you like to keep playing?"
  input=gets.chomp.downcase
  if input=="n"||input=="no"
    puts "Exiting"
    loops=false
  elsif input=="y"||input=="yes"
    puts "Great!\n"
    asking=true
    checking=true
    (0..7).each do |i|
      (0..7).each do |j|
        print grid[i][j]
      end
      puts
    end
    puts
  elsif input=="help"
    (0..7).each do |i|
      (0..7).each do |j|
        print ships[i][j]
      end
      puts
    end
  else
    puts "Bad input, but I'll assume you want to continue playing.\n"
    asking=true
    checking=true
    (0..7).each do |i|
      (0..7).each do |j|
        print grid[i][j]
      end
      puts
    end
    puts
  end
end
end
end
end
