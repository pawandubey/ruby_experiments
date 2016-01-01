#block access order
blocks = [10, 19, 3, 14, 12, 9]
start = 10
time = 0
blocks.sort!.rotate!(blocks.index(10))
#blocks.delete! 10
for i in (1..blocks.size-1)
  if (blocks[i])
    time += (blocks[i] - blocks[i-1]).abs
    puts (blocks[i] - blocks[i-1]).abs
  end
end
puts time.to_f/5
