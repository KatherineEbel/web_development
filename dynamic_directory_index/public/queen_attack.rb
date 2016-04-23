require 'pry'
# Board class is an 8x8 board with white and black markers
class Board
  NUM_ROWS = 8
  MARKERS = %w(W B).freeze
  attr_reader :locations
  def initialize(white, black)
    @white = white
    @black = black
    @locations = Array.new(NUM_ROWS) { Array.new(NUM_ROWS, "_") }
    place_markers
  end

  def to_s
    @locations.map { |row| row.join(' ') }.join("\n")
  end

  private

  def place_markers
    raise ArgumentError if @white.eql? @black
    @locations[@white.first][@white.last] = MARKERS.first
    @locations[@black.first][@black.last] = MARKERS.last
  end
end

# Queens class takes the positions of a white and black queen
# and determines if they are in attack range of each other.
class Queens
  attr_accessor :white, :black
  DEFAULTS = [[0, 3], [7, 3]].freeze
  def initialize(white: DEFAULTS.first, black: DEFAULTS.last)
    @white = white
    @black = black
    @board = Board.new(@white, @black)
  end

  def to_s
    @board.to_s
  end

  def attack?
    in_range_x? ||
      in_range_y? ||
      in_range_diagonal?
  end

  private

  def in_range_x?
    @white.first == @black.first
  end

  def in_range_y?
    @white.last == @black.last
  end

  def in_range_diagonal?
    x_difference = @white.first - @black.first
    y_difference = @white.last - @black.last
    x_difference.abs == y_difference.abs
  end
end
