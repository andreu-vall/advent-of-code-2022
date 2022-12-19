import java.lang.Integer.max

operator fun <T> List<T>.component6(): T = get(5) // ROFL needed to unpack > 5 elements
operator fun <T> List<T>.component7(): T = get(6)

fun compute(costs : Array<IntArray>, maximums : IntArray, robots : IntArray, resources : IntArray, minutes : Int): Int {
    if (minutes < 0) {
        return 0
    }
    if (minutes <= 1) {
        return resources.last() + minutes * robots.last()
    }
    var maxValue = resources.last()
    for (i in robots.indices) {
        //We can only spawn 1 robot/minute, so generating more than the maximum needed/robot is useless
        if (robots[i] < maximums[i] && robots.zip(costs[i]){ r, c -> !(c >= 1 && r==0) }.all{ it }) {
            var res = resources
            var min = minutes
            while (! res.zip(costs[i]){ x, y -> x - y}.all{ it >= 0}) { //Wait till I get enough resources to build the
                res = res.zip(robots){ x, y -> x + y}.toIntArray()      //robot (there needs to be a robot producing em)
                min -= 1
            }
            min -= 1
            res = res.zip(robots){ x, y -> x + y}.toIntArray()      // Get the resources of the minute
            res = res.zip(costs[i]){ x, y -> x - y}.toIntArray()    // Add another robot
            robots[i] += 1
            maxValue = max(maxValue, compute(costs, maximums, robots, res, min))
            robots[i] -= 1
        }
    }
    return maxValue
}

fun main() {
    val begin = System.nanoTime()
    var suma = 0
    var mult = 1
    for ((i, line) in generateSequence(::readLine).toList().withIndex()) {
        //Yay with this kind of inputs regex is god. it variable appears from nowhere 😮
        val ipList = Regex("[0-9]+").findAll(line).map{ it.groupValues[0].toInt()}.toList()
        val (b_id, ore_ore, clay_ore, obs_ore, obs_clay, geo_ore, geo_obs) = ipList //Can't use the existing variable...

        val costs = Array(4) { IntArray(4) } //Ore, clay, obsidian, geode
        costs[0][0] = ore_ore
        costs[1][0] = clay_ore
        costs[2][0] = obs_ore; costs[2][1] = obs_clay
        costs[3][0] = geo_ore; costs[3][2] = geo_obs
        val maxOre = intArrayOf(ore_ore, clay_ore, obs_ore, geo_ore).maxOrNull() ?: 0
        val maximums = intArrayOf(maxOre, obs_clay, geo_obs, 999999)
        suma += b_id * compute(costs, maximums, intArrayOf(1, 0, 0, 0), IntArray(4), 24)
        if (i < 3) {
            mult *= compute(costs, maximums, intArrayOf(1, 0, 0, 0), IntArray(4), 32)
        }
    }
    println("Part 1: $suma") //That's cool, here is perfect to use $
    println("Part 2: $mult")
    val end = System.nanoTime()
    println("Elapsed time in seconds: ${(end-begin) / 1_000_000_000}") //1st part takes 1 second, 2nd part 30 sec
}
