#include <stdio.h>

#include "mylib1_priv.h"
#include "mylib1.h"

void mylib1_function() {
    printf("mylib%d_function\n", LIB_ID);
}
