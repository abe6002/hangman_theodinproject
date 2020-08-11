#Board class for Hangman Project
#should have method for loading dictionary and picking word - should initialize with word
#should have method to build board with empty spaces - during initialize
#should have method to guess (player class)
#should have method to check for win
#should have method for computer guess (computer class?)
#should have method to swap turns

require_relative "player"

class Board

    def initialize(player_name)
        @word = File.readlines("5desk.txt").sample.chomp
        @player = Player.new(player_name)
        @board = ""

        @word.each_char {|char| @board += "_"}
    end

    def check_for_letter
        letter = @player.guess?

        if @word.include?(letter)
            idx = @word.index(letter)
            @board[idx] = letter
        end


    end

end
