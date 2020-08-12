#Computer Player Class

class Computer

    attr_accessor :guesses, :attempts, :name

    def initialize
        names = ["Doug", "Bob", "Steve", "Keith", "Garth"]

        @name = names.sample
        @guesses = []
        @attempts = 6
    end

    def comp_guess
        alpha = ("a".."z").to_a
        guess = (alpha-@guesses).sample
        @guesses << guess

        self.guesses.last
    end
end
