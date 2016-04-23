require 'pry'

# the CircularBuffer class is a fixed size array that reads and writes values.
class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end
  def initialize(val)
    @size = val
    @buffer = []
  end

  def read
    raise BufferEmptyException if @buffer.empty?
    @buffer.delete_at(-1)
  end

  def write(val)
    raise BufferFullException if full?
    @buffer.unshift val unless val.nil?
  end

  def full?
    @buffer.size == @size
  end

  def write!(val)
    return if val.nil?
    read if full?
    write val
  end

  def clear
    @buffer.clear
  end
end
