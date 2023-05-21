require_relative 'player'

class Computer < Player
  attr_accessor :unused_codes, :wrong_codes

  def initialize
    @unused_codes = [5, 6]
    @wrong_codes = []
    super
  end

  def give_code
    p "Codemaker(AI) gave the code (* * * *)"
    Array.new(4) { rand(1..6) }
  end

  def guest_code
    #starting guest
    p "AI is scheming. . ."
    sleep(1)
    return self.current_guest = [1, 2, 3, 4] if feedback_code.empty?
    # get the code with feedback code 1
    wrong_positions = feedback_code.map.with_index{ |fbc, index| (fbc == 1) ? current_guest[index] : nil }.compact
    correct_positions = feedback_code.map.with_index{ |fbc, index| (fbc == 2) ? current_guest[index] : nil }.compact
    self.wrong_codes += feedback_code.map.with_index{ |fbc, index| (fbc == 0) ? current_guest[index] : nil }.compact

    wrong_positions = wrong_positions.length > 3 ? wrong_positions.shuffle : wrong_positions
    p wrong_positions
    ## create the code with present info
    self.current_guest =
    feedback_code.map.with_index do |fbc, index|
      case fbc
      when 2 then current_guest[index] #retain code
      when 1
        wrong_positions.pop || unused_codes.pop || (correct_positions - wrong_codes).pop
      else
        wrong_positions.pop || unused_codes.pop || (correct_positions - wrong_codes).pop
      end
    end
  end
end
