require_relative 'game'
require_relative 'human'
require_relative 'computer'

class Game
  attr_accessor :game_sets, :computer, :human, :code

  def initialize
    @code = []
    @game_sets = 1

    @computer = Computer.new
    @human = Human.new
  end

  def start
    p 'Ready for a game of mastermind? You will play against an AI. Y/N'
    return if gets.chomp.downcase != "y"

    #how many sets will be played
    while self.game_sets.to_i.odd?
      p 'Pick how many set of game, must be even number: '
      self.game_sets = gets.chomp.to_i
    end

    game_set_for(game_sets)
    announce_winner
  end

  def game_set_for(set_number)
    #sets who is codemaker and codebreaker for each set
    players = [computer, human]
    set_number.times do |index|
      start_set(index, *(index.odd? ? players.reverse : players))
    end
  end

  def start_set(set_number, codemaker, codebreaker)
    #codemaker sets code_to_guest
    self.code = codemaker.give_code

    #codebreaker guest the code
    12.times do |index|
      p "Enter guest #{index + 1}: "

      codebreaker.receive_feedback(validate_guest codebreaker.guest_code)
      break if solved_by?(codebreaker) # and store score for code_breaker
    end
    #score
    solved_by?(codebreaker) ? codebreaker.score += 1 : codemaker.score += 1
    p "MANKIND: #{human.score}"
    p "AI: #{computer.score}"
  end

  def validate_guest(solution=[])
    return if solution.empty?
    return [2, 2, 2, 2] if code == solution

    #compare currentcode  vs solution
    code.map.with_index do |code_part, index|
      if code_part == solution[index]
        2 # correct
      elsif code.include? solution[index]
        1 # correct wrong position
      else
        0 # not part of cnode
      end
    end
  end

  def solved_by?(codebreaker)
    codebreaker.feedback_code.uniq == [2]
  end

  def announce_winner
    if human.score > computer.score
      p "Mankind won the fierce battle of the MIND"
    elsif computer.score > human.score
      p "AI won the battle you bastard, you let Mankind down"
    else
      puts "For now the word rest, as Machine and Mankind\n is of the same level in terms of thinking capacity"
    end
  end
end
