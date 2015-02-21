require 'set'
class WordChainer
  DICTIONARY = 'dictionary.txt'
  def initialize(dictionary_file_name = DICTIONARY)
    @dictionary = Set.new File.readlines(dictionary_file_name).map do |line|
      line.chomp
    end
  end

  def adjacent_words(word)
    dictionary.select do |potential|
      

    end
  end
end
