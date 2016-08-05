require 'lingua/stemmer'
require 'set'

module Bayes
  class Base
    attr_accessor :stemmer, :stop_words

    def initialize
      @stemmer = Lingua::Stemmer.new
      @stop_words = File.read("stop_words.list").split(/\W+/)
    end

    def tokenize(text)
      if block_given?
        text.split(/\W+/).each do |word|
          yield(@stemmer.stem(word)) unless @stop_words.include? word
        end
      end
    end
  end

  class Naive < Bayes::Base
    attr_accessor :model, :categories

    def initialize
      @model = Hash.new { |h,k| h[k] = Hash.new(0) }
      @categories = Set.new
      super
    end

    def classify(text)
      cat_weight = Math.log(1.0 / @categories.size)
      ratings = {}

      @categories.each do |category|
        features_weight = 0.0
        tokenize(text) do |word|
          features_weight += Math.log get_word_weight(word, category)
        end
        ratings[category] = cat_weight + features_weight
      end

      ratings
    end

    def train(category, data)
      @categories << category.to_sym

      tokenize(data) do |word|
        @model[word][category.to_sym] += 1
      end
    end

    def get_word_count(word, category=nil)
      if category.nil?
        @model.fetch(word).reduce(0) do |sum, (_, v)|
          sum += v
        end
      elsif @categories.include? category.to_sym
        @model.fetch(word)[category.to_sym] || 0
      end
    rescue
      0
    end

    def get_word_weight(word, category)
      total_word_count = get_word_count(word)
      total_word_count = 1 if total_word_count == 0
      (get_word_count(word, category).to_f + 1) / (total_word_count + @model.keys.size)
     end
  end
end
