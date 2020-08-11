#Player class for Hangman Project

class Player

    attr_accessor :guesses

    def initialize(name)
        @name = name
        @turn = true
        @guesses = []
    end

    def valid_guess?(guess) #need to return something indicating false
        alpha = ("a".."z").to_a
        !@guesses.include?(guess) && alpha.include?(guess)
    end

    def guess? #need to return something indicating false
        puts "#{@name}, enter your guess:"
        guess = gets.to_s.downcase.chomp
        if valid_guess?(guess)
            @guesses << guess
        end

        self.guesses.last
    end

    

end