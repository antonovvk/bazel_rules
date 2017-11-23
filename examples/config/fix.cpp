#include <iostream>

#include "examples/config/foo.h"
#include "examples/config/bar.h"
#include "examples/config/jar.h"
#include "examples/config/hello.h"

int main(int, char*[]) {

#ifdef FLAG
    std::cout << FOO << ", " << BAR << ", " << JAR << std::endl;
#else
    std::cout << "Not configured" << std::endl;
#endif

    std::cout << HELLO << std::endl;

    return 0;
}
