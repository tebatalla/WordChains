require 'set'
require 'byebug'
class WordChainer
  DICTIONARY = 'dictionary.txt'
  def initialize(dictionary_file_name = DICTIONARY)
    @dictionary = Set.new File.readlines(dictionary_file_name).map do |line|
      line.chomp
    end
  end

  def adjacent_words(word)
    adjacent_words = []
    word.each_char.with_index do |old_letter, i|
      ('a'..'z').each do |new_letter|
        next if old_letter == new_letter
        new_word = word.dup
        new_word[i] = new_letter

        adjacent_words << new_word if @dictionary.include?(new_word)
      end
    end
    adjacent_words
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }

    until @current_words.empty? || @all_seen_words.include?(target)
      explore_current_words(@current_words)
    end
    build_path(target)
  end

  private

  def explore_current_words(current_words)
    new_current_words = []
    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        next if @all_seen_words.include? adjacent_word
        new_current_words << adjacent_word
        @all_seen_words[adjacent_word] = current_word
      end
    end
    @current_words = new_current_words
  end

  def build_path(target)
    path = [target]
    until target.nil?
      path << @all_seen_words[target] if @all_seen_words[target]
      target = @all_seen_words[target]
    end
    path.reverse
  end
end
