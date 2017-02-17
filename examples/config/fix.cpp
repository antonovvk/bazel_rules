#include <iostream>

#include "examples/config/foo.h"
#include "examples/config/bar.h"
#include "examples/config/jar.h"

int main(int, char*[]) {

#ifdef FLAG
    std::cout << FOO << ", " << BAR << ", " << JAR << std::endl;
#else
    std::cout << "Not configured" << std::endl;
#endif

    return 0;
}
