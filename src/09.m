
fileID = fopen('09.txt', 'r');

rope = zeros(10, 2);
global dic
dic = dictionary("2,0,0", 1, "10,0,0", 1);
global cnt
cnt = ones(10);

line = fgetl(fileID);
while ischar(line)
    move = line(1);
    numb = str2num(line(3:end));
    for i = 1 : numb
        if move == 'R'      rope(1, 1) = rope(1, 1) + 1;
        elseif move == 'L'  rope(1, 1) = rope(1, 1) - 1;
        elseif move == 'D'  rope(1, 2) = rope(1, 2) + 1;
        else                rope(1, 2) = rope(1, 2) - 1;
        end

        for j = 1 : 9
            if abs(rope(j, 1)-rope(j+1, 1)) == 2 | abs(rope(j, 2)-rope(j+1, 2))==2
                if rope(j+1, 1) < rope(j, 1)    rope(j+1, 1) = rope(j+1, 1) + 1; end
                if rope(j+1, 1) > rope(j, 1)    rope(j+1, 1) = rope(j+1, 1) - 1; end
                if rope(j+1, 2) < rope(j, 2)    rope(j+1, 2) = rope(j+1, 2) + 1; end
                if rope(j+1, 2) > rope(j, 2)    rope(j+1, 2) = rope(j+1, 2) - 1; end
            end
        end

        myfunc(2, rope);
        myfunc(10, rope);
    end

    line = fgetl(fileID);
end
fclose(fileID);

disp(cnt(2));
disp(cnt(10));

function y = myfunc(x, rope)
    global dic
    global cnt
    tail = strcat(int2str(x), ",", int2str(rope(x, 1)), ",", int2str(rope(x, 2)));
    if ~isKey(dic, tail)
        dic(tail) = 0;
        cnt(x) = cnt(x) + 1;
    end
    dic(tail) = dic(tail) + 1;
end
