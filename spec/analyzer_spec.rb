require "./ultra_text_analyzer"

RSpec.describe UltraTextAnalyzer do
  describe ".analyze" do
    
    let(:long_text) { "Hey how are you doing? Have you seen Bob lately? Lately I heard  he was doing a new job, but I'm not sure what. Susan was in Europe last week for her job for vacation. Have you talked to her? Lately she's been hard to catch up with. What have y'all been doing lately?"}
    
    describe "when searching for contractible words" do 
      it "should find each occurence of 'let us'" do 
        expect(UltraTextAnalyzer.analyze("Let us go to the store")).to include("Contractible words: 1")
      end

      it "should find each occurence of a word followed by 'is' without punctuation" do
        expect(UltraTextAnalyzer.analyze("He is going to the store.")).to include("Contractible words: 1")
      end

      it "should find each occurence that a subset of words are followed by 'not'" do 
        expect(UltraTextAnalyzer.analyze("John did not go to the store.")).to include("Contractible words: 1")
      end

      it "should find each occurence of 'I' followed by [am, have]" do 
        expect(UltraTextAnalyzer.analyze("I have gone to the store.")).to include("Contractible words: 1")
      end

      it "should find each occurence of 'have' preceded by [would, should, could, we, they, you, must]" do 
        expect(UltraTextAnalyzer.analyze("John should have gone to the store.")).to include("Contractible words: 1") 
      end

      it "should find each occurence of a word followed by 'has'" do 
        expect(UltraTextAnalyzer.analyze("John has got to go the store.")).to include("Contractible words: 1")
      end
    end

    it "should output the correct word count" do
      results = UltraTextAnalyzer.analyze("hello, my friend.")
      expect(results).to include("3 words")
    end

    it "should output the correct character count" do
      results = UltraTextAnalyzer.analyze("hello, my friend.")
      expect(results).to include("17 characters")
    end

    it "should output the correct space count" do
      results = UltraTextAnalyzer.analyze("hello, my friend.")
      expect(results).to include("2 spaces")
    end

    it "should output the most common word, regardless of capitalization" do
      results = UltraTextAnalyzer.analyze(long_text)
      expect(results).to include("Most common word: lately")
    end

    it "should output the longest word" do
      results = UltraTextAnalyzer.analyze(long_text)
      expect(results).to include("Longest word: vacation")
    end

    it "should output the longest word regardless of adjacent punctuation" do 
      results = UltraTextAnalyzer.analyze("sushi bowl....")
      expect(results).to include("Longest word: sushi")
    end

    it "should output the correct word count regardless of abnormal spacing" do 
      results = UltraTextAnalyzer.analyze("    hello,   my friend.")
      expect(results).to include("8 spaces")
    end

    it "should output nil if given any value that is not a string" do
      results = UltraTextAnalyzer.analyze(8)
      expect(results).to eq(nil)
    end
  end
end
