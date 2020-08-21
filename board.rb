#Board class for Hangman Project
#should have method for loading dictionary and picking word - should initialize with word - GOOD
#should have method to build board with empty spaces - during initialize - GOOD
#should have method to guess (player class) - GOOD
#should have method to guess entire word
#should have method to check for win - OKAY
#should have method to check for loss - OKAY
#should have computer_player class - GOOD
#should have method for computer guess 
#should have method to swap turns - GOOD
#should have method to save the board state

require_relative "player"
require_relative "computer_player"
require "yaml"

class Board

    attr_accessor :board, :current_player, :player, :computer, :word

    def initialize(player_name)
        @word = File.readlines("5desk.txt").sample.downcase.chomp
        @player = Player.new(player_name)
        @computer = Computer.new
        @current_player = @player
        @board = ""

        @word.each_char {|char| @board += "_"}
    end

    def check_letter(letter)
        if @word.include?(letter)
            @word.each_char.with_index {|char, idx| @board[idx] = letter if char == letter}
        else
            puts "There are no #{letter}'s in this word - sorry!"
            @current_player.attempts -= 1
        end
    end
    
    def check_word
        puts "Guess the complete word:"
        word_guess = gets.downcase.chomp
        if word_guess == @word
            puts "#{@current_player.name} wins game!" #not sure if this is the right spot for this
            return true
        else
            puts "Wrong guess!"
            @current_player.attempts -=1
        end
    end

    def check_guess #need to add functionality for "save" and make another method for it.
        if @current_player == @player

            guess = @player.guess?

            if guess == "solve"
                self.check_word
            elsif guess == "save"
                Board.save_game(self) #need to test if this works
            else
                check_letter(guess)
            end
            
        else
            letter = @computer.comp_guess

            puts "#{@computer.name} the Computer guesses #{letter}"
            check_letter(letter)
        end

        self.print
    end

    def print
        puts "Word: #{@board} \nGuesses Remaining: #{@current_player.attempts}"
    end

    def win? 
        if @board == @word
            puts "#{@current_player.name} wins game!"
            return true
        end

        false
    end

    def lose?
        if @current_player.attempts == 0
            puts "#{@current_player.name} loses the game :(" 
            return true
        end

        false
    end

    def switch_turns
        if @player == @current_player
            return @current_player = @computer
        else
            @current_player = @player
        end
    end
    
    def self.save_game(data)
        puts "Type a name for your saved game"
        game_name = gets.chomp
        filename = "#{game_name}.yml"
        Dir.mkdir('./saved_games') unless Dir.exists?('./saved_games')

        ex_file = File.expand_path("./saved_games/#{filename}")
        if File.exists?(ex_file)
            puts "#{filename} already exists."
            save_game(data)
        else
            File.open(ex_file, "w") do |f|
                f.puts YAML::dump(data)
                puts "Your game was saved as #{game_name}"
            end
        end

    end

    def self.saved_games
        @game_array = []
        if Dir.glob("./saved_games/*").length > 0
            Dir.glob("./saved_games/*").each do |file_name| 
                @game_array << File.basename(file_name, '.yml') #populates array with game names, removes the .yml
            end

            game_count = 1
            @game_array.each do |game_path| #prints out a list of games and numbers, numbers 
                p "#{game_count} - #{game_path}"
                game_count += 1
            end

        Board.choose_saved

        else
            puts "No saved games."
        end

    end

    def self.choose_saved
        puts "Which game would you like to play?"
        @game_name = @game_array[gets.chomp.to_i - 1] #sets game_name to indexed file name, lots of room for errors if you dont guess int
    end

    def self.load_game #doesn't work - need to figure out a way to mutate current instance variables
        Board.saved_games

        board_state = YAML::load(File.read("./saved_games/#{@game_name}.yml"))

        self.board = board_state.board
        self.computer = board_state.computer
        self.current_player = board_state.current_player
        self.player = board_state.current_player
        self.word = board_state.word

    end

end