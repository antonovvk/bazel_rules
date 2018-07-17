package go_version

import (
	"fmt"
)

var (
	GitVersion = "UNDEFINED"
	BuildDate  = "UNDEFINED"
	BuildUser  = "UNDEFINED"
	BuildHost  = "UNDEFINED"
)

func Version() string {
	return fmt.Sprintln("Version: ", GitVersion, BuildDate, BuildUser, BuildHost)
}
