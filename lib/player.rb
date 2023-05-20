class Player
  attr_accessor :feedback_code, :current_guest, :score

  def initialize
    @current_guest = []
    @feedback_code = []
    @score = 0
  end

  def guest_code
    self.current_guest = gets.chomp.split('').map(&:to_i)
    return guest_code if  current_guest.length != 4

    current_guest
  end

  def give_code
    code = gets.chomp.split('').map(&:to_i)
    return guest_code if  code.length != 4

    code
  end

  def receive_feedback(feedback = [])
    self.feedback_code = feedback
    p feedback_code
    p current_guest
  end
end
