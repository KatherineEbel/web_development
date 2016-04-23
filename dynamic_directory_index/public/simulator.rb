require 'pry'

class Robot
  attr_accessor :bearing, :coordinates, :advance
  ORIENATIONS = [:north, :south, :east, :west].freeze
  def initialize
    @coordinates = [0, 0]
    @bearing
  end

  def at(x, y)
    @coordinates = [x, y]
  end

  def turn_left
    case @bearing
    when :east then orient ORIENATIONS.first
    when :west then orient ORIENATIONS[1]
    when :south then orient ORIENATIONS[2]
    when :north then orient ORIENATIONS.last
    end
  end

  def turn_right
    @bearing = case @bearing
    when :east then ORIENATIONS[1]
    when :west then ORIENATIONS.first
    when :south then ORIENATIONS.last
    when :north then ORIENATIONS[2]
    end
  end

  def advance
    case @bearing
    when :east then at @coordinates.first + 1, @coordinates.last
    when :west then at @coordinates.first - 1, @coordinates.last
    when :south then at @coordinates.first, @coordinates.last - 1
    when :north then at @coordinates.first, @coordinates.last + 1
    end
  end

  def orient(direction)
    raise ArgumentError unless ORIENATIONS.include? direction
    @bearing = direction
  end
end

class Simulator
  INSTRUCTIONS = {advance: 'A', turn_left: 'L', turn_right: 'R' }.freeze

  def instructions(string)
    string.each_char.map { |instruction| INSTRUCTIONS.key instruction }
  end

  def place(robot, x:, y:, direction:)
    robot.at x, y
    robot.orient direction
  end

  def evaluate(robot, string)
    instructions(string).each do |instruction|
      robot.send instruction
    end
  end
end
