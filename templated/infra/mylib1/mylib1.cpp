#include <stdio.h>

#include "lib1_priv.h"
#include "mylib1.h"

void mylib1_function() {
    Lib1Op op = LIB1_OP_WRITE;

    printf("mylib1_function, op: %d\n", op);
}
