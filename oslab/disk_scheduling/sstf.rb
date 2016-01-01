#block access order
blocks = [19, 3, 14, 12, 9]
#done = [10]

time = 0
start = 10
# blocks.sort! { | a, b | (10 - a).abs <=> (10 - b).abs }
# puts blocks
while blocks.size > 0
  nextPos = 0
  for j in (0...blocks.size-1)
    if (start - blocks[j]).abs < (start - blocks[nextPos]).abs
      nextPos = j
    end
  end
  puts blocks[nextPos]
  time += (start - blocks[nextPos]).abs
  start = blocks[nextPos]
  blocks.delete blocks[nextPos]
end

puts time.to_f/5
