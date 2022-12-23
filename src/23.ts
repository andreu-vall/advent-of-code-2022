const readline = require('readline')

const reader = readline.createInterface({input: process.stdin, output: process.stdout, terminal: false})

function to_string(tuple: [number, number]) : string {
    return tuple[0] + "," + tuple[1]
}

function get_positions([i, j] : [number, number], direction : number) : Array<[number, number]> {
    if (direction == 0) { //North
        return [[i-1, j-1], [i-1, j], [i-1, j+1]]
    } else if (direction == 1) { //South
        return [[i+1, j-1], [i+1, j], [i+1, j+1]]
    } else if (direction == 2) { //East
        return [[i-1, j-1], [i, j-1], [i+1, j-1]]
    } else { //West
        return [[i-1, j+1], [i, j+1], [i+1, j+1]]
    }
}

function move(elves: Array<[number, number]>, step : number) : Array<[number, number]> {
    let elves_set : Set<string> = new Set(elves.map(to_string)) //A set of tuples is not properly hashed...
    let new_elves : Array<[number, number]> = []
    let new_elves_set : Set<string> = new Set()
    let new_elves_invalid : Set<string> = new Set()
    for (let [i, j] of elves) {
        let new_pos : [number, number] = [i, j]
        let changed : boolean = false
        let free_count : number = 0
        for (let direction : number = 0; direction < 4; direction++) {
            let [left, mid, right] = get_positions([i, j], (direction + step) % 4)
            if (!elves_set.has(to_string(left)) && !elves_set.has(to_string(mid)) && !elves_set.has(to_string(right))) {
                if (!changed) {
                    new_pos = mid
                    changed = true
                }
                free_count += 1
            }
        }
        if (free_count == 4) {
            new_pos = [i, j]
        }
        new_elves.push(new_pos)
        if (new_elves_set.has(to_string(new_pos))) {
            new_elves_invalid.add(to_string(new_pos))
        } else {
            new_elves_set.add(to_string(new_pos))
        }
    }
    for (let i : number = 0; i < elves.length; i++) {
        if (new_elves_invalid.has(to_string(new_elves[i]))) {
            new_elves[i] = elves[i]
        }
    }
    return new_elves
}

let elves : Array<[number, number]> = []
let height : number = 0
reader.on('line', (line : string) => {
    for (let j = 0; j < line.length; j++)
        if (line.charAt(j) == '#')
            elves.push([height, j])
    height += 1
})
reader.on('close', () => {
    let step : number = 0
    let all_equal : boolean = false
    while (!all_equal) {
        let new_elves = move(elves, step)
        all_equal = true
        for (let i : number = 0; i < elves.length; i++) {
            if (to_string(new_elves[i]) != to_string(elves[i])) {
                all_equal = false
                break
            }
        }
        elves = new_elves
        step++
        if (step == 10) {
            let min_i : number = Infinity, max_i : number = -Infinity
            let min_j : number = Infinity, max_j : number = -Infinity
            elves.forEach(pos => {
                min_i = Math.min(min_i, pos[0])
                max_i = Math.max(max_i, pos[0])
                min_j = Math.min(min_j, pos[1])
                max_j = Math.max(max_j, pos[1])
            })
            console.log("Part 1:", (max_i - min_i + 1) * (max_j - min_j + 1) - elves.length)
        }
    }
    console.log("Part 2:", step)
})
