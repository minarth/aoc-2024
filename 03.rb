def read_input(input)
  input
end

def part_one(input)
  # parsing here because not knowing whats needed for part2
  sum = 0
  parsed = input.scan(/mul\((\d{1,3}),(\d{1,3})\)/).map{|s| s.map(&:to_i)}
  parsed.each do |(x,y)|
    sum += x*y
  end
  sum
end

def part_two(input)
  parsed = input.gsub(/(don\'t\(\).*?do\(\))/m, ".")
  #print parsed
  if parsed.include?("don't()")
    parsed = parsed.split("don't()")[0]
  end
  part_one(parsed)
end


input = %{xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))}


p1 = part_one(*read_input(input))
p2 = part_two(*read_input(input))
print "TEST: '#{p1}' '#{p2}' \n"


input = File.read("data/03")
p1 = part_one(*read_input(input))
p2 = part_two(*read_input(input))
print "RUN: '#{p1}' '#{p2}' \n"