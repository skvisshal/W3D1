require_relative "./Player.rb"

class Game
    def self.file_reader(input)
        file = File.open(input)
        file_data = file.readlines.map(&:chomp)
        file.close
        dictionary = Hash.new{|h,k| h[k] = []}
        file_data.each do |word|
            dictionary[word[0]] << word
        end
        dictionary
    end

    def initialize
        @fragment = ""
        @player_1 = Player.new
        @player_2 = Player.new
        @current_player = @player_1
        @previous_player = @player_2
        @dictionary = Game.file_reader("./dictionary.txt")
    end

    def next_player!
        if @current_player == @player_1
            @current_player = @player_2
            @previous_player = @player_1
        else
            @current_player = @player_1
            @previous_player = @player_2
        end
    end
    

    def take_turn(player)

        loop do 
            puts "Fragment : #{@fragment}"
            puts "Enter letter: "
            response = gets.chomp
            if response == "challange"

            elsif response == "forfeit"
                return false
            end
            break if !legal_response?(response) && !legal_fragment?(response)
        end
        @fragment += response
        self.next_player!
        true
    end

    def play_round
        while take_turn(@current_player)
        end
        puts "Game Over, Winner is #{@previous_player}"
    end

    def legal_fragment?(letter)
        return true if @fragment.empty?
        p @dictionary[@fragment[0]].include?(@fragment + letter) 
        @dictionary[@fragment[0]].include?(@fragment + letter)
        
    end

    def legal_response?(response)
        alph = ('a'..'z').to_a
        return false if response.length != 1
        return false if !alph.include?(response)
        true
    end


    def dictionary
        @dictionary
    end
end

g= Game.new

g.play_round