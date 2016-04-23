# The Octal class takes digit string and converts it
# to an octal number if valid.
class Octal
  def initialize(val)
    @numbers = val
  end

  def to_decimal
    return 0 if invalid?
    @numbers.oct
  end

  private

  def invalid?
    @numbers.chars.map.any? { |num| [8, 9].include? num.to_i }
  end
end
