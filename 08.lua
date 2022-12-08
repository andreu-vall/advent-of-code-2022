my_lines = {}
line = io.read()
num_lines = 0
while (line ~= nil)
do
  my_lines[num_lines] = line
  num_lines = num_lines + 1 -- I miss += 1 or ++...
  line = io.read()
end

string_length = #my_lines[0] --That's gangster

counter = 0
counted = {}
for i=0, num_lines-1 do
  counted[i] = {}
end

function count_line(new_position, i, j)
  height = -1
  while (i >= 0 and i < string_length and j >= 0 and j < num_lines 
    and height < 9)
  do
    val = tonumber(string.sub(my_lines[i], j+1, j+1)) -- weird indexing 1...
    if (val > height) then
      if (counted[i][j] == nil) then
        counted[i][j] = 1
        counter = counter + 1
      end
      height = val
    end
    i, j = new_position(i, j)
  end
end

down = function(i, j) return i+1, j end
up = function(i, j) return i-1, j end
left = function(i, j) return i, j+1 end
right = function(i, j) return i, j-1 end

for j=0, string_length-1 do
  count_line(down, 0, j)
  count_line(up, num_lines-1, j)
end

for i=0, num_lines-1 do
  count_line(left, i, 0)
  count_line(right, i, string_length-1)
end

print(counter)

part2 = 0

function count_lower(new_position, i, j)
  height = tonumber(string.sub(my_lines[i], j+1, j+1))
  i, j = new_position(i, j)
  counter = 0
  while (i >= 0 and i < string_length and j >= 0 and j < num_lines 
    and tonumber(string.sub(my_lines[i], j+1, j+1)) < height)
  do
    i, j = new_position(i, j)
    counter = counter + 1
  end
  if (i >= 0 and i < string_length and j >= 0 and j < num_lines) then
    counter = counter + 1
  end
  return counter
end


for i=0, num_lines-1 do
  for j=0, string_length-1 do
    val_down = count_lower(down, i, j)
    val_up = count_lower(up, i, j)
    val_left = count_lower(left, i, j)
    val_right = count_lower(right, i, j)
    val = val_down * val_up * val_left * val_right
    if (val > part2) then
      part2 = val
    end
  end
end

print(part2)
