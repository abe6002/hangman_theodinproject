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

    attr_accessor :attempts, :board, :current_player, :player, :computer

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

    def save_game
        file_as = "#{@computer.name}.yml"
        save = [@word, @player, @computer, @current_player, @board]
    
        f = File.open ( file_as , w)
        YAML.dump(save, f)
        f.close
    end

    def check_guess #need to add functionality for "save" and make another method for it.
        if @current_player == @player

            guess = @player.guess?

            if guess == "solve"
                self.check_word
            elsif guess == "save"
                self.save_game
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


end
