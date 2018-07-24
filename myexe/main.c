#include <stdio.h>

#include "mylib1.h"
#include "mylib2.h"

int main()
{
    printf("myexe calling mylib1_function:\n");
    mylib1_function();

    printf("myexe calling mylib2_function:\n");
    mylib2_function();

    return 0;
}

