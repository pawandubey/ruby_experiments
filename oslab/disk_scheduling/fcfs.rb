#block access order
blocks = [10, 19, 3, 14, 12, 9]

time = 0

for i in (1..blocks.size-1) do
  val = (blocks[i] - blocks[i-1]).abs
  puts val
  time += val
end

puts time.to_f/5
