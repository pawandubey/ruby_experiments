input = [111, 112, 220, 69, 134, 85]
result = []

input.each do |n|
  sum = (1..n).to_a.select { |i| n % i == 0 }.reduce(:+)

  result <<  if sum > (2 * n)
            "abundant by #{sum - (2 * n)}"
          elsif sum < (2 * n)
            "deficient"
          else
            "neither"
          end
end

puts result
