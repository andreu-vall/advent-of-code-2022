program Hello;
{$H+} //By default string can only have 256 chars and we need this to increase it...
var
  myline: string;

function first_different(mystring: string; long: integer): integer;
var
  last, i, j: integer;
  found: boolean;
begin
  last:=long-1;
  while (not found) do
    begin;
    last:=last+1;
    found:=true;
    //Arrays start at index 1
    for i:=last-long+1 to last-1 do
      begin;
      for j:=i+1 to last do
        begin;
        if mystring[i]=mystring[j] then
          found:=false;
        end;
      end;
    end;
  first_different:=last;
end;

begin
  readln(myline);
  writeln(first_different(myline, 4));
  writeln(first_different(myline, 14));
end.