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

class Board

    attr_accessor :attempts, :board, :current_player, :player, :computer

    def initialize(player_name)
        @word = File.readlines("5desk.txt").sample.chomp
        @player = Player.new(player_name)
        @computer = Computer.new
        @current_player = @player.name
        @board = ""

        @word.each_char {|char| @board += "_"}
    end

    def check_for_letter
        letter = @player.guess?

        if @word.include?(letter)
            idx = @word.index(letter)
            @board[idx] = letter
        else
            @attempts -= 1
        end

        self.print
    end

    def print
        puts "Word: #{@board} \nGuesses Remaining: #{@attempts}"
    end

    def win? #not done - need to make it current player - UNTESTED
        if @board == @word
            puts "Player wins game!"
            return true
        end

        false
    end

    def lose? #UNTESTED
        if @attempts == 0
            puts "Player loses the game :(" 
            return true
        end

        false
    end

    def switch_turns
        if @player.name == @current_player
            return @current_player = @computer.name
        else
            @current_player = @player.name
        end
    end


end
