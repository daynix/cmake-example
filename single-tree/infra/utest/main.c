#include <stdio.h>

#include "mylib1.h"
#include "mylib2.h"

int main()
{
    printf("utest calling mylib1:\n");
    mylib1_function();

    printf("utest calling mylib2:\n");
    mylib2_function();

    return 0;
}

