require "matrix"

lines = []
line = gets
while line
  line = line.strip
  if !line.index('S').nil?
    start_i, start_j = [lines.length, line.index('S')]
  end
  if !line.index('E').nil?
    end_i, end_j = [lines.length, line.index('E')]
  end
  lines.append(line)
  line = gets
end

def get_height(mychar)
  if mychar == 'S'
    mychar = 'a'
  elsif mychar == 'E'
    mychar = 'z'
  end
  return mychar.ord - 'a'.ord
end
  

def bfs(lines, start_i, start_j, end_symbol, order=1)
  pending = Queue.new
  pending << [start_i, start_j, 0]

  steps = Matrix.zero(lines.length, lines[0].length)
  
  while pending.length > 0
    i, j, s = pending.pop
    if lines[i][j] == end_symbol
      return s
    end
    if steps[i, j] > 0 and s >= steps[i, j]
      next
    end
    steps[i, j] = s
    for i2, j2 in [[i+1,j], [i-1,j], [i,j+1], [i,j-1]]
      if 0 <= i2 and i2 < lines.length and 0 <= j2 and j2 < lines[0].length and (steps[i2,j2]==0 or s+1 < steps[i2,j2])
        if order==1 and get_height(lines[i2][j2])-1 <= get_height(lines[i][j])
          pending << [i2, j2, s+1]
        elsif order==2 and get_height(lines[i][j])-1 <= get_height(lines[i2][j2])
          pending << [i2, j2, s+1]
        end
      end
    end
  end
  return -1
end

puts bfs(lines, start_i, start_j, 'E')
puts bfs(lines, end_i, end_j, 'a', 2)
