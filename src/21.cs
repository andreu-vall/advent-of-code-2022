IDictionary<string, long> values = new Dictionary<string, long>();
IDictionary<string, (string, string, string)> operations = new Dictionary<string, (string, string, string)>();

string? line = Console.ReadLine();
while (!String.IsNullOrEmpty(line)) {
    string name = line.Substring(0, 4); //Start, length
    string right = line.Substring(6);
    var isNumeric = long.TryParse(right, out long numb);
    if (name == "humn") {
        Console.WriteLine("Detected");
        line = Console.ReadLine();
        continue;
    }
    if (isNumeric) {
        values[name] = numb;
    }
    else {
        operations[name] = (right.Substring(0, 4), right.Substring(5, 1), right.Substring(7));
    }
    line = Console.ReadLine();
}

(string root_left, string _, string root_right) = operations["root"];
operations.Remove("root");

Console.WriteLine(values.Count);
Console.WriteLine(operations.Count);

bool changed = true;
while (changed) {
    changed = false;
    foreach(KeyValuePair<string, (string, string, string)> entry in operations) {
        if (values.ContainsKey(entry.Value.Item1) && values.ContainsKey(entry.Value.Item3)) {
            long left = values[entry.Value.Item1];
            string op = entry.Value.Item2;
            long right = values[entry.Value.Item3];
            long ans = 0;
            if (op == "+") {
                ans = left + right;
            } else if (op == "*") {
                ans = left * right;
            } else if (op == "-") {
                ans = left - right;
            } else if (op == "/") {
                ans = left / right;
                long mod = left % right;
                if (mod != 0) {
                    Console.WriteLine("YIKES");
                }
            } else {
                Console.WriteLine("FFFFF");
            }
            values[entry.Key] = ans;
            operations.Remove(entry.Key);
            changed = true;
        }
    }
}

Console.WriteLine(values.Count);
Console.WriteLine(operations.Count);

operations["root"] = (root_left, "-", root_right);
values["root"] = 0;

string actual = "root";
while (actual != "humn") {
    (string left_op, string op, string right_op) = operations[actual];
    if (!values.ContainsKey(left_op) && !values.ContainsKey(right_op)) {
        Console.WriteLine("FF");
    }
    if (op == "+" || op == "*") {
        string known, unkwown;
        if (values.ContainsKey(left_op)) {
            known = left_op;
            unkwown = right_op;
        } else {
            known = right_op;
            unkwown = left_op;
        }
        if (op == "+") {
            values[unkwown] = values[actual] - values[known];
        } else {
            values[unkwown] = values[actual] / values[known];
        }
        actual = unkwown;
        Console.WriteLine("Done");
    }
    else if (op == "-") {
        if (!values.ContainsKey(left_op)) {
            values[left_op] = values[actual] + values[right_op];
            actual = left_op;
        }
        else {
            values[right_op] = values[left_op] - values[actual];
            actual = right_op;
        }
    }
    else {
        if (!values.ContainsKey(left_op)) {
            values[left_op] = values[actual] * values[right_op];
            actual = left_op;
        }
        else {
            values[right_op] = values[left_op] / values[actual];
            actual = right_op;
        }
    }
}

Console.WriteLine(values["humn"]);

//Console.WriteLine(values["root"]);

Console.WriteLine(values[root_right]);
Console.WriteLine(values[root_left]);
