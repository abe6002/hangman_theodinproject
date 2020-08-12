#Player class for Hangman Project

class Player

    attr_accessor :guesses, :name, :attempts

    def initialize(name)
        @name = name
        @guesses = []
        @attempts = 6
    end

    def valid_guess?(guess) 
        alpha = ("a".."z").to_a
        !@guesses.include?(guess) && alpha.include?(guess)
    end

    def guess?
        puts "#{@name}, enter your guess:"
        guess = gets.to_s.downcase.chomp
        if valid_guess?(guess)
            @guesses << guess
        else
            puts "That is not a valid guess."
            self.guess?
        end

        self.guesses.last
    end

    

end