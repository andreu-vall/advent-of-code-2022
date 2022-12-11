import Foundation

class Monkey {
  var items : [Int]
  var op : String
  var op_itself : Bool
  var op_numb : Int?
  var divisor : Int
  var if_true : Int
  var if_false : Int
  var inspect_count = 0
  
  var items2 : [Int] //For part 2, copying classes looked more painful
  var inspect_count2 = 0
  
  init() {
    var line = readLine()! //If not unwrapped everything sucks
    line = line.components(separatedBy: ": ")[1] //Int doesn't work with spaces...
    items = line.components(separatedBy: ", ").map { Int($0)! }
    
    line = readLine()!.components(separatedBy: "old ")[1]
    let sep = line.components(separatedBy: " ")
    op = sep[0]
    op_itself = (sep[1]=="old")
    if (!op_itself) {
      op_numb = Int(sep[1])! //Kinda painful ngl
    }
    
    divisor = Int(readLine()!.components(separatedBy: "by ")[1])!
    if_true = Int(readLine()!.components(separatedBy: "monkey ")[1])!
    if_false = Int(readLine()!.components(separatedBy: "monkey ")[1])!
    
    items2 = items
  }
  
  //It kinda overcomplicat una mica, yikes. No hi ha pas per referència :/
  func inspect(monkeys : [Monkey], div_total : Int = 0) {
    for var item in (div_total == 0 ? items : items2) {
      if op_itself {
        op_numb = item
      }
      item = op == "*" ? item * op_numb! : item + op_numb!
      
      item = div_total == 0 ? item / 3 : item % div_total
      
      let monkey_goal = item % divisor == 0 ? if_true : if_false
      
      if (div_total == 0) { monkeys[monkey_goal].items.append(item) }
      else                { monkeys[monkey_goal].items2.append(item) }
    }
    if (div_total == 0) {
      inspect_count += items.count
      items = []
    }
    else {
      inspect_count2 += items2.count
      items2 = []
    }
  }
}

var monkeys = [Monkey]()
while (readLine() != nil) {
  monkeys.append(Monkey())
  readLine()
}

for _ in 1...20 {
  for monkey in monkeys {
    monkey.inspect(monkeys : monkeys) //Only one argument why name??
  }
}

var counts = monkeys.map { $0.inspect_count } //Yikes I forgot the "var"
counts.sort(by: >)
print(counts[0] * counts[1]) //Ok Swift sucks can only access last


//HEHEHEHE
let div_total = monkeys.map { $0.divisor }.reduce(1, *)

for _ in 1...10000 {
  for monkey in monkeys {
    monkey.inspect(monkeys : monkeys, div_total : div_total)
  }
}

counts = monkeys.map { $0.inspect_count2 }
counts.sort(by: >)
print(counts[0] * counts[1])
