#size of processes in order
processes = [212, 417, 112, 426]

#size of memory segments in order
memory = [100, 500, 200, 300, 600]

#result array storing the final segment of process i
result = []
#place according to first fitting segment
processes.each_with_index do |proc|
    memory.each_with_index do |mem, index|
      if mem >= proc
        memory[index] -= proc
        result << index
        break
      end
    end
end

puts result
