class Anagram
  def initialize(word)
    @word = word
    @length = word.length
  end

  def match(words)
    words.each.map do |word|
      next if invalid? word
      word if sorted_matches? word
    end.compact
  end

  private

  def invalid?(word)
    word.length != @length || @word.casecmp(word) == 0
  end

  def sorted_matches?(word)
    @word.downcase.chars.sort == word.downcase.chars.sort
  end
end
