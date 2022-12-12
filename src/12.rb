require "matrix"

pending = Queue.new
lines = []
line = gets
while line
  line = line.strip
  start_tmp = line.index('S')
  if !start_tmp.nil?
    pending << [lines.length, start_tmp, 0]
    line[start_tmp] = 'a'
  end
  end_tmp = line.index('E')
  if !end_tmp.nil?
    end_i, end_j = [lines.length, end_tmp]
    line[end_tmp] = 'z'
  end
  lines.append(line)
  line = gets
end

best = 99999

for start_i in (0..lines.length-1)
  for start_j in (0..lines[0].length-1)
    if lines[start_i][start_j] != 'a'
      next
    end
    
    pending = Queue.new
    pending << [start_i, start_j, 0]

    steps = Matrix.zero(lines.length, lines[0].length)
    
    while pending.length > 0
      i, j, s = pending.pop
      if steps[i, j] == 0 or steps[i, j] < s
        steps[i, j] = s
        if i==end_i and j==end_j
          if s < best
            best = s
          end
          break
        end
        for i2, j2 in [[i+1,j], [i-1,j], [i,j+1], [i,j-1]]
          if 0 <= i2 and i2 < lines.length and 0 <= j2 and j2 < lines[0].length and (steps[i2,j2]==0 or s+1 < steps[i2,j2])
            height = lines[i2][j2].ord - 1
            if height <= lines[i][j].ord
              pending << [i2, j2, s+1]
            end
          end
        end
      end
    end
  end
end
puts best
