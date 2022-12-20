readline = require('readline')

//Couldn't even get the data with synchronous stdin: prompy-sync invented lines and fs.readFileSync(0) only read 4098 Bytes...
const reader = readline.createInterface({input: process.stdin, output: process.stdout, terminal: false})

function move(numbers, times=1) {
    let length = numbers.length //WTF if I write wrong a property it doesn't give an error (legnth)
    let positions = [...Array(length).keys()]
    for (let time = 0; time < times; time++) {
        for (let it = 0; it < length; it++) { //If iterating values in array, it's needed 'of' instead of 'in'!!!
            let index = positions.findIndex(e => e == it) //I used find...
            let direc = (numbers[it] >= 0) ? 1 : -1
            let moves = Math.abs(numbers[it]) % (length - 1) //Fuck shouldn't count itself while rotating...
            while (moves--) {
                new_index = (index + direc + length) % length; //WHYY do I need the semicolon here???. Also WHY THE FUCK gives
                [positions[new_index], positions[index]] = [positions[index], positions[new_index]] //negative modulo?????
                index = new_index
            }
        }
    }
    let index = positions.map(e => numbers[e]).findIndex(e => e == 0)
    return [0, 1, 2, 3].map(e => numbers[positions[(index + 1000*e) % length]]).reduce((a, b) => a+b, 0)
}
var numbers = []
reader.on('line', line => { numbers.push(Number(line)) })
reader.on('close', () => {
    console.log(move(numbers))
    console.log(move(numbers.map(e => e*811589153), 10))
})
