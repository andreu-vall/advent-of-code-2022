use std::io;
use std::cmp;
use std::collections::HashMap;
use std::collections::HashSet;
use kdam::tqdm;

/*Could also be useful:

println!("{:?}", array);

fn print_type_of<T>(_: &T) {
    println!("{}", std::any::type_name::<T>());
}*/

fn binary_length(number : usize, length : usize) -> String {
    let right = format!("{:b}", number);
    return "0".repeat(length - right.len()) + &right;
}

fn compute_win(valve_comb : usize, flow_n : usize, flow_pressure : &Vec<u32>) -> u32 {
    return binary_length(valve_comb, flow_n).chars().zip(flow_pressure).map(|(c, v)| v*((c=='1') as u32)).sum::<u32>();
}

fn gen_moves(valve : usize, valve_comb : usize, flow_n : usize, valve_hash : &HashMap<String, usize>,
        edges : &Vec<HashSet<String>>, valve_to_flow : &HashMap<usize, usize>) -> Vec<(usize, usize)> {

    let mut moves = Vec::new(); //There are no easy iterators like Python yield...

    for other_valve_str in &edges[valve] { //Move to adjacent valve
        moves.push((valve_comb, valve_hash[other_valve_str]));
    }
    if valve_to_flow.contains_key(&valve) { //If in positive flow valve and not already active, active it
        let power_value = usize::pow(2, (flow_n - 1 - valve_to_flow[&valve]) as u32);
        if valve_comb % (2 * power_value) < power_value {
            moves.push((valve_comb + power_value, valve));
        }
    }
    return moves;
}

fn bound_sup(val : u32, minutes : u32, minute : u32, flow_pressure : &Vec<u32>) -> u32 {
    let max_pressure : u32 = flow_pressure.iter().sum();
    return val + max_pressure * (minutes - minute);
}

fn bound_inf(val : u32, win : u32, minutes : u32, minute : u32) -> u32 {
    return val + win * (minutes - minute);
}

fn main() {

    let mut valve_hash : HashMap<String, usize> = HashMap::new(); //string_id -> 0, 1, 2, ...
    let mut valve_n : usize = 0;

    let mut valve_to_flow  = HashMap::new(); //valve -> positive flow position
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
    // ---------------------------------- PART 1 ----------------------------
    let minutes = 30;
    let valve_comb_n = usize::pow(2, flow_n as u32);    //Using an auto type assigned variable might change its type
    let mut dp1 = vec![vec![0; valve_n]; valve_comb_n]; //and make crash other things that worked!!
    let mut dp2 = vec![vec![0; valve_n]; valve_comb_n];
    dp2[0][valve_hash["AA"]] = 1; //Cas inicial (added 1 extra as not to have -1's)
    let mut greater_than = 0;
    for minute in 0..minutes {
        std::mem::swap(&mut dp1, &mut dp2);
        for valve_comb in 0..valve_comb_n {
            for valve in 0..valve_n {
                if dp1[valve_comb][valve] > 0 && bound_sup(dp1[valve_comb][valve], minutes, minute, &flow_pressure) >= greater_than {
                    let win = compute_win(valve_comb, flow_n, &flow_pressure);
                    greater_than = cmp::max(greater_than, bound_inf(dp1[valve_comb][valve], win, minutes, minute));
                    for (new_valve_comb, new_valve) in gen_moves(valve, valve_comb, flow_n, &valve_hash, &edges, &valve_to_flow).iter() {
                        if dp1[valve_comb][valve] + win > dp2[*new_valve_comb][*new_valve] {
                            dp2[*new_valve_comb][*new_valve] = dp1[valve_comb][valve] + win;
                        }
                    }
                }
            }
        }
    }
    let mut max_value = 0;
    for vector1d in dp2.iter() {
        for value in vector1d.iter() {
            if *value > max_value {
                max_value = *value;
            }
        }
    }
    println!("Part 1: {}", max_value - 1);

    //---------------------------- PART 2 ----------------------
    let minutes = 26;
    let mut dp1 = vec![vec![vec![0; valve_n]; valve_n]; valve_comb_n];
    let mut dp2 = vec![vec![vec![0; valve_n]; valve_n]; valve_comb_n];
    dp2[0][valve_hash["AA"]][valve_hash["AA"]] = 1;
    let mut greater_than = 0;
    for minute in tqdm!(0..minutes) {
        std::mem::swap(&mut dp1, &mut dp2);
        for valve_comb in 0..valve_comb_n {
            for valve1 in 0..valve_n {
                for valve2 in 0..valve_n {
                    if dp1[valve_comb][valve2][valve1] > 0 && bound_sup(dp1[valve_comb][valve2][valve1], minutes, minute, &flow_pressure)
                            >= greater_than {
                        let win = compute_win(valve_comb, flow_n, &flow_pressure);//Yikes forgetting here^ the equal was slow to debug...
                        greater_than = cmp::max(greater_than, bound_inf(dp1[valve_comb][valve2][valve1], win, minutes, minute));
                        for (new_valve_comb, new_valve2) in gen_moves(valve2, valve_comb, flow_n, &valve_hash, &edges, &valve_to_flow).iter() {
                            for (new_new_valve_comb, new_valve1) in
                                    gen_moves(valve1, *new_valve_comb, flow_n, &valve_hash, &edges, &valve_to_flow).iter() {
                                if dp1[valve_comb][valve2][valve1] + win > dp2[*new_new_valve_comb][*new_valve2][*new_valve1] {
                                    dp2[*new_new_valve_comb][*new_valve2][*new_valve1] = dp1[valve_comb][valve2][valve1] + win;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    let mut max_value = 0;
    for vector2d in dp2.iter() {
        for vector1d in vector2d.iter() {
            for val in vector1d.iter() {
                if *val > max_value {
                    max_value = *val;
                }
            }
        }
    }
    println!("Part 2: {}", max_value - 1);
}
