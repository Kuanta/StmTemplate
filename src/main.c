#include "stm32f0xx.h"

int main()
{
    RCC->AHBENR |= RCC_AHBENR_GPIOAEN;
    while(1)
    {

    }
    return 0;
}