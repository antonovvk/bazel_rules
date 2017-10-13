#include <iostream>

#include "examples/git_version/cc_git_version.h"

int main(int, char*[]) {
    std::cout << git_version::GitVersion() << std::endl;
    return 0;
}
