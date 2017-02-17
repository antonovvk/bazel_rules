#include <iostream>

#include "examples/config/gen_cfg.h"

int main(int, char*[]) {

#ifdef FLAG
    std::cout << VALUE << std::endl;
#else
    std::cout << "Not configured" << std::endl;
#endif

    return 0;
}
