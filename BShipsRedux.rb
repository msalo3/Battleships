class BattleshipGrid
  @row
  @column

  attr_accessor :user_grid
  attr_accessor :answer_grid
  attr_accessor :row
  attr_accessor :column
  attr_accessor :ship_count

  def initialize
    @user_grid=[]
    @answer_grid=[]
    @easy_switch=false
    @hard_switch=false
    @cannonballs=0
    @ship_count=0
    @raft_checker=0
    @paddleboat_checker=0
    @cruiseship_checker=0
    @shipdrone_checker=0

  end
  def easy_or_hard
    puts "\tWelcome to Battle Ship!!\n\n"
    loop=true
    while loop
      puts "Please choose a difficulty: \n- (B)eginner\n- (A)dvanced"
      response=gets.chomp.downcase
      if response=="b" || response=="beginner"
        loop=false
        @easy_switch=true
      elsif response=="a" || response=="advanced"
        loop=false
        @easy_switch=false
      elsif response=="secret mode"
        loop=false
        @easy_switch=false
        @hard_switch=true
      else
        puts "Sorry, I didn't understand that. Try again please.\n"
      end
    end
  end

  def keep_playing
    loop=true
    #Checks to see if there are any ships remaining before
    #asking if the user would like to continue playing
    if @ship_count==0
      if @easy_switch==true
        puts "\n\n\tYou destroyed my tiny fleet!! Argh!"
        loop=false
        false
      else
        puts "\n\n\tYou're a worthy adversary."
        loop=false
        false
      end
    end
    while loop
      puts "\nWould you like to continue playing? (Yes or No?)"
      response=gets.chomp.downcase
      if @cannonballs==1
        loop=false
        system "clear"
        puts "\n\n\n\t\tYou ran out of cannonballs."
        puts "\n\t\tYou're terrible at Battleship.\n\n\n\n"
        return false
      elsif response=="y"||response=="yes"
        system "clear"
        @cannonballs-=1
        print_grid(@user_grid)
        if @hard_switch==true
          puts "\n\tYou have #{@cannonballs} cannonballs remaining.\n"
        end
        loop=false
        return true
      elsif response=="n"||response=="no"
        loop=false
        return false
      elsif response=="show grid"
        print_ship_grid
      else
        puts "\nPlease input a valid answer"
      end
    end
  end

  def sink_a_ship
    #This functions tells the user if they sunk one of the ships
    #It bundles each ships coordinates together
    if @user_grid[5][5]=="X" && @shipdrone_checker==0
      puts "You sunk the aqua Drone!"
      @shipdrone_checker=1
    end
    if @user_grid[0][0]=="X" && @user_grid[0][1]=="X" &&
      @user_grid[0][2]=="X" && @raft_checker==0
      puts "You sunk the raft!"
      @raft_checker=1
    end
    if @user_grid[7][7]=="X" && @user_grid[6][7]=="X" &&
      @user_grid[5][7]=="X" && @user_grid[4][7]=="X" && @paddleboat_checker==0
      puts "You sunk the paddleboat!"
      @paddleboat_checker=1
    end
    if @user_grid[2][2]=="X" && @user_grid[3][2]=="X" &&
      @user_grid[4][2]=="X" && @user_grid[5][2]=="X" &&
      @user_grid[6][2]="X" && @user_grid[7][2]="X" && @cruiseship_checker==0
      puts "You sunk the Cruise Ship!"
      @cruiseship_checker=1
    end

  end

  def populate_user_grid(length,width)
    @user_grid=Array.new(length){Array.new(width){false}}
    @user_grid
  end

  def populate_answer_grid(length, width)
    @answer_grid=Array.new(length){Array.new(width){false}}
    #raft coordinates
    @answer_grid[0][0]=true
    @answer_grid[0][1]=true
    @answer_grid[0][2]=true
    #paddleboat coordinates
    @answer_grid[7][7]=true
    @answer_grid[6][7]=true
    @answer_grid[5][7]=true
    @answer_grid[4][7]=true
    if @easy_switch==false
      #cruise ship coordinates
      @answer_grid[2][2]=true
      @answer_grid[3][2]=true
      @answer_grid[4][2]=true
      @answer_grid[5][2]=true
      @answer_grid[6][2]=true
      @answer_grid[7][2]=true
      #ship drone coordinates
      @answer_grid[5][5]=true
    end
    #loops through the entire grid to find the total number of ships on the grid
    (0..7).each do |i|
      (0..7).each do |j|
        if @answer_grid[i][j]==true
          @ship_count+=1
        end
      end
    end
    @cannonballs=@ship_count+2
    @answer_grid
  end

  def get_row
    loop=true
    while loop
      puts "Row (1-8): "
      @row=gets.to_i
      if @row>0&&@row<9
        loop=false
        return @row-1
      else
        puts "Invalid. Try Again\n"
      end
    end
  end
  def get_column
    loop=true
    while loop
      puts "Column (1-8): "
      @column=gets.to_i
      if @column>0&&@column<9
        loop=false
        return @column-1
      else
        puts "Invalid. Try Again\n"
      end
    end
  end
  def print_grid(grid)
    puts "\n"
    (0..7).each do |i|
      (0..7).each do |j|
        if grid[i][j]==true
          print "0 "
        elsif grid[i][j]==false
          print "- "
        elsif grid[i][j]=="M"
          print "M "
        elsif grid[i][j]=="X"
          print "X "
        end
      end
      puts
    end
    puts "\n"
  end
  def print_ship_grid()
    puts "\n"
    (0..7).each do |i|
      (0..7).each do |j|
        if @answer_grid[i][j]==true
          print "0 "
        elsif @answer_grid[i][j]==false
          print "- "
        elsif @answer_grid[i][j]=="M"
          print "M "
        elsif @answer_grid[i][j]=="X"
          print "X "
        end
      end
      puts
    end
    puts "\n"
  end
  def check_grid(row, column)
    if @answer_grid[row][column]==true
      if @user_grid[row][column]=="X"
        puts "You already tried that spot!"
        puts "The X on the grid means you hit there already!!"
      else
        puts "You got a hit!"
        @user_grid[row][column]="X"
        @ship_count-=1
      end
    elsif @easy_switch==true && (@answer_grid[row-1][column-1] ||
      @answer_grid[row-1][column] || @answer_grid[row-1][column+1] ||
      @answer_grid[row][column-1] || @answer_grid[row][column+1] ||
      @answer_grid[row+1][column-1] || @answer_grid[row+1][column] ||
      @answer_grid[row+1][column+1])
      puts "You missed, but you got so close!!"
      @user_grid[row][column]="M"
    else
      puts "You missed!"
      @user_grid[row][column]="M"
    end
  end
end


system "clear"
game=BattleshipGrid.new
game.easy_or_hard
empty=game.populate_user_grid(8,8)
cheat=game.populate_answer_grid(8,8)

game.print_grid(empty)

looping=true

while looping
  row=game.get_row
  column=game.get_column
  game.check_grid(row, column)
  game.sink_a_ship
  looping=game.keep_playing
end
