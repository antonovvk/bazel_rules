package main

import (
	"fmt"
	"os"
	"git_version"
)

func main() {
    fmt.Fprintf(os.Stdout, "Version: %s\n", git_version.GitVersion)
}
