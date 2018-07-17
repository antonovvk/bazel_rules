#include <iostream>

#include "examples/cc_version/version.h"

int main(int, char*[]) {
    std::cout
        << "Version: " << STABLE_GIT_TAG
        << " " << STABLE_BUILD_DATE
        << " " << BUILD_USER << "@" << BUILD_HOST
        << std::endl;
    return 0;
}
