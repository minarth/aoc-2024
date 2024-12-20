def read_input(input)
  lines = input.split("\n")
  processed = []
  lines.each do |l|
    processed << l.split().map(&:to_i)
  end  
  [processed]
end


def validate_line(line)
  diff = []
  line[0..-2].zip(line[1..-1]).each do |el0, el1|
    # print el0, el1, el0-el1, "\n"
    diff << el0-el1
    if (el0-el1).abs == 0 || (el0-el1).abs > 3
      return false
    end
  end
  
  if diff.all?(&:positive?) || diff.all?(&:negative?)
    return true
  end

  return false
end

def part_one(input)
  valid = 0
  input.each do |i|
    if validate_line(i)
      # print i
      valid += 1
    end
  end
  valid
end


def part_two(input)
  valid = 0
  input.each do |i|
    diff = []
    diff_vals = []
    acceptable_val = []
    i[0..-2].zip(i[1..-1]).each do |el0, el1|
      # print el0, el1, el0-el1, "\n"
      d = el0-el1
      diff << d
      diff_vals << d.positive?
      acceptable_val << (d.abs > 0 && d.abs <= 3)
    end
    
    pos_count, neg_count = diff_vals.count{|elem| elem}, diff_vals.count{|elem| !elem}
    non_acc_count = acceptable_val.count{|e| !e}
    if (pos_count == i.size-1 || neg_count == i.size-1) && non_acc_count == 0
      valid += 1
    elsif (pos_count < 2 || neg_count < 2) && non_acc_count < 2

      print "##########################\n"
      print i, diff, diff_vals, acceptable_val, "\n"
      print pos_count, neg_count, non_acc_count, "\n"
      i.each_with_index do |_, idx|
        if validate_line(i.reject.with_index { |_, index| index == idx })
          print "valid #{i.reject.with_index { |_, index| index == idx }}\n"
          valid += 1
          break

        end
      end 
    end
  end
  valid
end

input = %{7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9}



print "PARTONE\n"
p1 = part_one(*read_input(input))
print "PARTTWO\n"
p2 = part_two(*read_input(input))
print "TEST: '#{p1}' '#{p2}' \n"


input = File.read("data/02")
p1 = part_one(*read_input(input))
p2 = part_two(*read_input(input))
print "RUN: '#{p1}' '#{p2}' \n"

