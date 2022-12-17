use std::io;
use std::cmp;
use std::collections::HashMap;
use std::collections::HashSet;

fn print_type_of<T>(_: &T) {
    println!("{}", std::any::type_name::<T>())
}

fn binary_length(number : usize, length : usize) -> String {
    let right = format!("{:b}", number);
    return "0".repeat(length - right.len()) + &right;
}

fn compute_win(comb : String, valve_flow : &Vec<u32>) -> u32 {
    let mut win = 0;
    for (i, c) in comb.chars().enumerate() {
        if c == '1' {
            win += valve_flow[i];
        }
    }
    return win;
    //return comb.chars().collect::<Vec<char>>().iter().zip(valve_flow).map(|(&i1, &i2)| i1.parse().unwrap() * i2).sum();
    //const RADIX: u32 = 10;
    //let x = "134";
    //println!("{}", x.chars().map(|c| c.to_digit(RADIX).unwrap()).sum::<u32>());
}

fn main() {

    let mut valve_hash = HashMap::new(); //string_id -> 0, 1, 2, ...
    let mut valve_n = 0;

    let mut valve_to_flow = HashMap::new(); //valve -> positive flow position
    let mut flow_to_valve = Vec::new(); //Flow position -> valve
    let mut flow_pressure = Vec::new();
    let mut flow_n : usize = 0;

    let mut edges = Vec::new();
    
    for line_wrapped in io::stdin().lines() {
        let mut line = line_wrapped.unwrap();
        let valve_id = (&line["Valve ".len() .. "Valve ".len()+2]).to_string();
        line = (&line["Valve EE has flow rate=".len()..]).to_string();
        let split_word = if line.contains("tunnels") { "; tunnels lead to valves " } else { "; tunnel leads to valve " };
        let split_line: Vec<String> = line.split(split_word).map(|s| s.to_string()).collect();
        let flow_rate : u32 = split_line[0].parse().unwrap();
        let tunnels : HashSet<String> = split_line[1].split(", ").map(|s| s.to_string()).collect();
        
        valve_hash.insert(valve_id, valve_n);

        if flow_rate > 0 {
            valve_to_flow.insert(valve_n, flow_n);
            flow_to_valve.push(valve_n);
            flow_pressure.push(flow_rate);
            flow_n += 1;
        }
        edges.push(tunnels);

        valve_n += 1
    }
    let minutes = 30;
    let valve_comb_n = usize::pow(2, flow_n as u32); //Using an auto type assigned variable might change its type
    let mut dp = vec![vec![vec![0; valve_n]; valve_comb_n]; minutes+1]; //and make crash other things that worked!!
    dp[0][0][valve_hash["AA"]] = 1; //Cas inicial (added 1 extra as not to have -1's)

    for minute in 0..minutes {
        for valve_comb in 0..valve_comb_n {
            for valve in 0..valve_n {
                if dp[minute][valve_comb][valve] > 0 {
                    //println!("minute: {}, valve_comb: {}, valve: {}, pressure: {}", minute, valve_comb, valve, 
                    //    dp[minute][valve_comb][valve]);
                    let mut comb = binary_length(valve_comb, flow_n);
                    let win = compute_win(comb.clone(), &flow_pressure);
                    for other_valve_str in &edges[valve] {
                        dp[minute+1][valve_comb][valve_hash[other_valve_str]] = cmp::max(dp[minute][valve_comb][valve] + win, 
                            dp[minute+1][valve_comb][valve_hash[other_valve_str]]);
                    }
                    if valve_to_flow.contains_key(&valve) {
                        //println!("Can activate {}", valve);
                        //println!("Before {}", comb.clone());
                        comb.replace_range(valve_to_flow[&valve]..valve_to_flow[&valve]+1, "1");
                        //println!("After {}", comb.clone());
                        let new_valve_comb = usize::from_str_radix(&comb, 2).unwrap();
                        //println!("Value: {}", new_valve_comb);
                        dp[minute+1][new_valve_comb][valve] = cmp::max(dp[minute][valve_comb][valve] + win, 
                            dp[minute+1][new_valve_comb][valve]);
                        //println!("Put value: {}", dp[minute+1][new_valve_comb][valve]);
                        //assert!(false);
                    }
                }
            }
        }
    }
    //println!("{:?}", array);
    println!("Finished");
    
    let mut max_value = 0;
    for valve_comb in 0..valve_comb_n {
        for valve in 0..valve_n {
            if dp[minutes][valve_comb][valve] > max_value {
                max_value = dp[minutes][valve_comb][valve];
            }
        }
    }
    println!("Answer 1: {}", max_value - 1);
}
