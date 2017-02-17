#include <iostream>

#include "cc_version.h"

int main(int, char*[]) {
    std::cout << cc_version::GitVersion() << std::endl;
    return 0;
}
