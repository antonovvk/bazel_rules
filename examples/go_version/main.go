package main

import (
	"fmt"
	"os"
	"examples/git_version"
)

func main() {
    fmt.Fprintf(os.Stdout, "Version: %s\n", git_version.GitVersion)
}
