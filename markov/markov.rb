# make a random walker using markov chain
# take a string as input and then walk it randomly
# 1. Take string as input and then find successors for each word -> store in a hash
# 2. Generate a random value and and seed word, then pick a random successor from its list of successors and keep doing it till N words are filled.

class Markov

  def initialize
    @successors = Hash.new { |h,k| h[k] = [] }
  end

  def read_file(file)
    # File.foreach(file) do |line|
    #   find_successors(line)
    #end
    contents = File.read(file)
    find_successors(contents)
  end

  def read_string(string)
    find_successors(string)
  end

  def generate(start, limit)
    #puts @successors
    random_walk(start, limit)
  end

  private

  def find_successors(string)
    words = string.split()

    words[0..-2].each.with_index do |word, i|
      @successors[word.to_sym] << words[i+1]
    end
  end

  def random_walk(start, limit)
    output = []
    next_w = start
    while (limit-=1) > 0
      ind = (Random.rand * @successors[next_w.to_sym].size).to_i
      #puts @successors[next_w].size, limit
      next_w = @successors[next_w.to_sym][ind]
      output << next_w
      #puts next_w, ind
    end
    @outstring = output.join(" ")
  end

end

if __FILE__ == $0
  mk = Markov.new
  # mk.read_string("hello world baby girl how are you I am fine but not so much look at the stars look how they shine for you")
  mk.read_file("styles.txt")
  puts mk.generate("for", 50)
end
