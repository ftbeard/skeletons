package main

import (
	"fmt"
	"os"
)

func sum(a int) func(...int) int {
	return func(b... int) int {
		for _, i := range b {
			a += i
		}
		return a
	}
}

func multiple() (a int, b int, c int, d string){
	a = 1
	b = 2
	c = 3
	d = "wesh"
	return
}

func main() {
	for i, a := range os.Args[1:] {
		fmt.Printf("Hello, world ! %d %s args\n", i+1, a)
	}

	a,b,c,d := multiple()
	fmt.Printf("value : %d %d %d %s\n", a, b, c, d)

	fmt.Println(multiple())

	add2 := sum(2)
	fmt.Println(add2(3,5))

}
