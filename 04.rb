def read_input(input)
  input
end

def count_str(lines, str)
  puts "#{lines}\n"
  lines.map{|line| line.scan(str).size}.sum() + lines.map{|line| line.reverse().scan(str).size}.sum()
end

def part_one_rotating(input)
  ## I want to learn arrays, iterators and string more. So I rotate the input and count occurences on the lines
  ## non working, going to variant with searching from each position into all directions
  input = input.split("\n")
  # count horizontal and reverse horizontal
  h = count_str(input, /XMAS/)

  # rotate vertical and diagonals starting from first line
  vertical = []
  lr_diag = []
  rl_diag = []
  input[0].each_char.with_index do |_, i|
    t_line = ""
    lr_line = ""
    rl_line = ""
    lr_i = 0
    rl_i = 0
    input.each do |line|
      t_line += line[i]
      if i+lr_i < line.size
        lr_line += line[i+lr_i]
        lr_i += 1
      end
      if i-rl_i >= 0
        rl_line += line[i-rl_i]
        rl_i += 1
      end      
    end
    vertical << t_line
    lr_diag << lr_line
    rl_diag << rl_line
  end

  # diagonals from second line
  puts "#{input.size} #{input[1..-1].size}\n"
  input[1..-1].each_with_index do |l, i|
    lr_shift = 1
    rl_shift = 1
    lr_line = l[0]
    rl_line = l[l.size-1]
    print "Starting with #{l}\n"
    input[i+1..-1].each_with_index do |l1, i1|
      if lr_shift < l1.size
        lr_line += l1[lr_shift]
        print " from #{l1} expanded #{lr_line}\n"
      end
      if l1.size-1-rl_shift >= 0
        rl_line += l1[l1.size-1-rl_shift]
      end      
      lr_shift += 1
      rl_shift += 1
    end
    lr_diag << lr_line
    rl_diag << rl_line
  end
  
  # count vertical and reverse vertical
  v = count_str(vertical, /XMAS/)
  print "LR\n"
  # left to right diagonals
  lr = count_str(lr_diag, /XMAS/)
  
  print "RL\n"

  rl = count_str(rl_diag, /XMAS/)
  
  h+v+rl+lr
end

def part_one(input, word="XMAS")
  input = input.split("\n")
  counter = 0
  input.each_with_index do |line, l_idx|
    line.each_char.with_index do |position, p_idx|
      # go horizontal
      h, h_r, v, v_r, lr, lr_r, rl, rl_r = "", "", "", "", "", "", "", ""
      
      for i in 0..word.size-1
        # horizontal
        if p_idx+i < line.size
          h << line[p_idx+i]
        end
        # horizontal reversed
        if p_idx-i >= 0
          h_r << line[p_idx-i]
        end
        # vertical 
        if l_idx+i < input.size
          v << input[l_idx+i][p_idx]
        end
        # vertical reversed
        if l_idx-i >= 0
          v_r << input[l_idx-i][p_idx]
        end
        # left-right diagonal
        if l_idx+i < input.size && p_idx+i < line.size
          lr << input[l_idx+i][p_idx+i]
        end
        # left-right diagonal reversed
        if l_idx-i >= 0 && p_idx-i >= 0
          lr_r << input[l_idx-i][p_idx-i]
        end
        # right-left diagonal
        if l_idx+i < input.size && p_idx-i >= 0
          rl << input[l_idx+i][p_idx-i]
        end
        # right-left diagonal reversed
        if l_idx-i >= 0 && p_idx+i < line.size
          rl_r << input[l_idx-i][p_idx+i]
        end

      end
      counter += 1 if h == word
      counter += 1 if h_r == word
      counter += 1 if v == word
      counter += 1 if v_r == word
      counter += 1 if lr == word
      counter += 1 if lr_r == word
      counter += 1 if rl == word
      counter += 1 if rl_r == word
      #print "#{v} #{v_r}\n"
      #
    end
  end
  counter
end

def diagonal_word(input, word="MAS")
  counter = 0
  input.each_with_index do |line, l_idx|
    line.each_char.with_index do |position, p_idx|
      # go horizontal
      lr, lr_r, rl, rl_r = "", "", "", "", "", "", "", ""
      
      for i in 0..word.size-1
        # left-right diagonal
        if l_idx+i < input.size && p_idx+i < line.size
          lr << input[l_idx+i][p_idx+i]
        end
        # left-right diagonal reversed
        if l_idx-i >= 0 && p_idx-i >= 0
          lr_r << input[l_idx-i][p_idx-i]
        end
        # right-left diagonal
        if l_idx+i < input.size && p_idx-i >= 0
          rl << input[l_idx+i][p_idx-i]
        end
        # right-left diagonal reversed
        if l_idx-i >= 0 && p_idx+i < line.size
          rl_r << input[l_idx-i][p_idx+i]
        end

      end
      counter += 1 if lr == word
      counter += 1 if lr_r == word
      counter += 1 if rl == word
      counter += 1 if rl_r == word
    end
  end
  counter
end

def part_two(input)
  input = input.split("\n")  
  counter = 0
  input[0..-3].each_with_index do |line, l_idx|
    
    line[0..-3].each_char.with_index do |position, p_idx|
      grid = []
      grid << input[l_idx][p_idx..p_idx+2]
      grid << input[l_idx+1][p_idx..p_idx+2]
      grid << input[l_idx+2][p_idx..p_idx+2]
      counter += 1 if diagonal_word(grid) == 2
    end
    
  end
  counter
end


input = %{MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX}


p1 = part_one(*read_input(input))
p2 = part_two(*read_input(input))
print "TEST: '#{p1}' '#{p2}' \n"


input = File.read("data/04")
p1 = part_one(*read_input(input))
p2 = part_two(*read_input(input))
print "RUN: '#{p1}' '#{p2}' \n"
# 2465 too low