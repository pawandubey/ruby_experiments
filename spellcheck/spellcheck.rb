class SpellCheck
  def correct(word)
    train_model

    prospects = find_similar(word)
    prospects
    corrections = find_closest(word, prospects)

    puts "possible corrections : #{corrections.join(' | ')}"
  end

  private
  def find_closest(word, prospects)
    samp_size = sample_size
    correction = prospects.min_by(5) {|v| edit_distance(word, v.to_s)}
  end

  def cond_probablity(key, word)

  end

  def sample_size
    @model.values.each.reduce(0) {|v,a| a+=v}
  end

  def find_similar(word)
    similars = @model.keys.find_all {|w| edit_distance(word, w.to_s) <= 2}
  end

  def train_model
    @path_to_sanitized_file = 'sanitized.txt'
    @model = Hash.new(1)

    File.foreach(@path_to_sanitized_file) do |line|
      line.split.each do |word|
        @model[word.to_sym] += 1
      end
    end
  end

  #Levenshtein Distance, taken from https://github.com/rubygems/rubygems/blob/master/lib/rubygems/text.rb
  def edit_distance(str1, str2)
    n = str1.length
    m = str2.length
    max = n/2

    return m if 0 == n
    return n if 0 == m || (n - m).abs > max

    d = (0..m).to_a
    x = nil
    str1.each_char.with_index do |char1,i|
      e = i+1

      str2.each_char.with_index do |char2,j|
        cost = (char1 == char2) ? 0 : 1
        x = [ d[j+1] + 1, # insertion
              e + 1,      # deletion
              d[j] + cost # substitution
            ].min
        d[j] = e
        e = x
      end
      d[m] = x
    end
    x
  end
end

word = ARGV[0].to_s
check = SpellCheck.new

check.correct(word)
