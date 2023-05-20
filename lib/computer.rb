require_relative 'player'

class Computer < Player
  def give_code
    p "Codemaker(AI) gave the code (* * * *)"
    Array.new(4) { rand(1..6) }
  end
end
