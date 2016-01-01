#block access order
blocks = [10, 19, 3, 14, 12, 9]

mark = []

time = 0

blocks.sort!
start = blocks.index(10)
blocks.rotate!(start)
blocks[blocks.size-start..-1] = blocks[blocks.size-start..-1].reverse
puts blocks
blocks[1..-1].each.with_index do |b,i|
  time += (blocks[i]-blocks[i-1]).abs
end

puts time.to_f./5
