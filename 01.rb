def process(input_arr)
  lines = input_arr.split("\n")
  left, right = [], []
  lines.each do |line|
    numbers = line.strip.split().map(&:to_i)
    left << numbers[0]
    right << numbers[1]
    
  end
  [left, right]
end

def part_one(left, right)
  
  answer = 0
  left = left.sort
  right = right.sort

  left.zip(right).each do |l, r|
    answer += (l-r).abs
  end
  answer
end

def part_two(left, right)
  
  answer = 0

  left.each do |l|
     answer += l*right.count(l)
  end
   
  # probably faster method
  # counter = right.group_by(&:itself).transform_values!(&:size)
  # counter.default = 0
  # left.each do |l|
  #   answer += l*counter[l]
  # end
  
  answer
end

################################
#####    TEST 
################################
input = %{3   4
4   3
2   5
1   3
3   9
3   3}

puts part_one(*process(input))
puts part_two(*process(input))

input = File.read("data/01")
puts part_one(*process(input))
puts part_two(*process(input))
