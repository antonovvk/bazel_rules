package main

import (
	"fmt"
	"os"
	"go_version"
)

func main() {
    fmt.Fprintf(os.Stdout, "Version: %s\n", go_version.GitVersion)
}
