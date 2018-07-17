package main

import (
	"fmt"
	"github.com/antonovvk/bazel_rules/go_version"
)

func main() {
	fmt.Println(go_version.Version())
}
