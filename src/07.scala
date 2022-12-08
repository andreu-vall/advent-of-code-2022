import scala.collection.mutable.ArrayBuffer

object HelloWorld {
  
  var sizes = ArrayBuffer[Int]() //Save all directory sizes for part 2
  
  def myfunc() : Array[Int] = {
    
    var line = scala.io.StdIn.readLine()
    assert(line == "$ ls")
    
    //Real size, suma answer part 1
    var mylist = Array(0, 0)
    
    line = scala.io.StdIn.readLine()
    while ((line != null) && (line != "$ cd ..")) {
      if (line(0) == '$') {
        val rec = myfunc()
        mylist(0) += rec(0)
        mylist(1) += rec(1)
      }
      else if (line(0) != 'd') {
        val split_line = line.split(" +")
        mylist(0) += split_line(0).toInt
      }
      line = scala.io.StdIn.readLine()
    }
    if (mylist(0) <= 100000)
      mylist(1) += mylist(0)
    
    sizes += mylist(0)
    
    return mylist
  }
  
	def main(args: Array[String]): Unit = {
	  
	  scala.io.StdIn.readLine()
	  val myvalue = myfunc()
	  println(myvalue(1))
	  
	  val used_space = myvalue(0)
	  var closest = Int.MaxValue
	  for (size <- sizes)
	    if ((used_space - size <= 40000000) && (size < closest))
        closest = size
	  println(closest)
	}
}