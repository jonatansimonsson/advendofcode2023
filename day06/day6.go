package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func main() {
	file, err := os.Open("input.txt")
	if err != nil {
		fmt.Println("no such file")
		os.Exit(1)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	var race []([]int)
	for scanner.Scan() {
		line := scanner.Text()
		re := regexp.MustCompile("[a-zA-z:]*")
		fmt.Println(concat(line))
		splitLine := re.ReplaceAllString(concat(line), "")
		fmt.Println(splitLine)
		race = append(race, getInts(splitLine))

		fmt.Println(race)
	}
	var totalA = 1
	for i := 0; i < len(race[0]); i++ {
		fmt.Println(race[0][i], race[1][i])
		var waysToWin = 0
		for j := 0; j < race[0][i]+1; j++ {

			if j*(race[0][i]-j) > race[1][i] {
				waysToWin++
			}
		}
		fmt.Println(waysToWin)
		totalA *= waysToWin

	}
	fmt.Println(totalA)
}

func concat(line string) string {
	return strings.Replace(line, " ", "", -1)
}
func getInts(line string) []int {
	var res []int

	words := strings.Fields(line)
	for _, word := range words {
		if num, err := strconv.Atoi(word); err == nil {
			res = append(res, num)
		}
	}
	return res
}
