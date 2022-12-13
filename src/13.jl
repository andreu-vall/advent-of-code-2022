
function parse_array(string, start=1)
    if isdigit(string[start])
        finish = start
        while isdigit(string[finish+1])
            finish += 1
        end
        return parse(Int64, string[start:finish]), finish+1
    end
    @assert string[start] == '['
    start += 1
    arr = Any[]
    while string[start] != ']'
        elem, start = parse_array(string, start)
        push!(arr, elem)
        if string[start] == ','
            start += 1
        end
    end
    return arr, start+1
end

function compare_string(left, right)
    if left < right
        return '<'
    elseif left == right
        return '='
    else
        return '>'
    end
end

function compare(left, right)
    if typeof(left) == Int64 && typeof(right) == Int64
        return compare_string(left, right)
    end
    if typeof(left) == Int64
        return compare([left], right)
    end
    if typeof(right) == Int64
        return compare(left, [right])
    end
    for (x, y) in zip(left, right)
        com = compare(x, y)
        if com != '='
            return com
        end
    end
    return compare_string(sizeof(left), sizeof(right))
end

left_string = readline()
right_string = readline()
readline()
counter = 0
index = 1
all_arrays = Any[[[2]], [[6]]]
while sizeof(left_string) > 0
    left = parse_array(left_string)[1]
    right = parse_array(right_string)[1]
    if compare(left, right) != '>'
        global counter += index
    end
    push!(all_arrays, left)
    push!(all_arrays, right)

    global left_string = readline() # No comments, at least inside
    global right_string = readline() # of the function it doesn't happen
    global index += 1
    readline()
end

println("Finished: ", counter)

answer2 = 1

for i in 1:length(all_arrays)-1 # Yikes I used sizeof which is another thing......
    swap = true
    while swap
        swap = false
        for j in i+1:length(all_arrays)
            if compare(all_arrays[i], all_arrays[j]) == '>'
                all_arrays[i], all_arrays[j] = all_arrays[j], all_arrays[i]
                swap = true
                break
            end
        end
    end
    if all_arrays[i] == [[2]] || all_arrays[i] == [[6]]
        global answer2 *= i
    end
end

println(answer2)
