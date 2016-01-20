
object HelloWorld {
    type R = Array[String]

    var list = List("1", "2", "3", "nope", "ca passe pas", "42")

    def double(in: Option[Int]): Option[Int] = {
        in match {
            case Some(i) => Some(i*2)
            case None    => None
        }
    }

    def toInt(in: String): Option[Int] = {
        try {
            Some(Integer.parseInt(in.trim))
        } catch {
            case e: NumberFormatException => None
        }
    }

    def printInt(in: Option[Int]): Unit = {
        in match {
            case Some(i) => println(i)
            case None    => ()
        }
    }

    def main(args: R): Unit = {
        list map toInt map double map printInt
    }
}
