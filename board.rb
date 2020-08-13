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
        @word = File.readlines("5desk.txt").sample.downcase.chomp
        @player = Player.new(player_name)
        @computer = Computer.new
        @current_player = @player
        @board = ""

        @word.each_char {|char| @board += "_"}
    end

    def check_for_letter #need to add functionality for "solve" and make another method for it.
        if @current_player == @player

            letter = @player.guess?

            if @word.include?(letter)
                @word.each_char.with_index {|char, idx| @board[idx] = letter if char == letter}
            else
                @current_player.attempts -= 1
            end

        else #if current_player is the computer

            letter = @computer.comp_guess

            if @word.include?(letter)
                @word.each_char.with_index {|char, idx| @board[idx] = letter if char == letter}
            else
                @current_player.attempts -= 1
            end
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


end
