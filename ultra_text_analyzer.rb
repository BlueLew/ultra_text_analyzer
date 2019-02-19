class UltraTextAnalyzer
  def self.analyze(text)
    return nil unless text.is_a? String
    result = ""
    total = 0
    let_us_regex =  /let\s+us/i
    is_regex = /[a-zA-z]+\s+is/
    not_regex = /(have|has|had|do|does|did|shall|will|should|could|would|must|can|are|was|were)\s+not/
    i_regex = /(\w|^)I\s+(have|am)/
    have_regex = /(would|should|could|we|they|you|must)\s+have/
    has_regex = /\w+\s+has/

    total += text.scan(let_us_regex).length
    total += text.scan(is_regex).length
    total += text.scan(not_regex).length
    total += text.scan(i_regex).length
    total += text.scan(have_regex).length
    total += text.scan(has_regex).length

    words = text.downcase.gsub(/[^\w\s-]/,"").split(" ")
    result = "#{words.length} words "
    result += "#{text.length} characters "
    result += "#{text.count(" ")} spaces "
    result += "Longest word: #{longest_word(words)} "
    result += "Most common word: #{most_common_word(words)} "
    result += "Contractible words: #{total}"
    result
  end

private

  def self.longest_word(words)
    words.max_by do |item|
      item.length
    end
  end

  def self.most_common_word(words)
    words.max_by { |item| words.count(item) }
  end
end


