#include <stdio.h>

extern long long int my_mul(long long int a, long long int b);
extern long long int power(long long int base, long long int exp);

int main(void)
{
    long long int a = my_mul(3, 5);
    printf("Result of my_mul(3, 5) = %lld\n", a);

    long long int base = 2;
    long long int exp = 5;
    long long int result = power(base, exp);
    printf("%lld to the power of %lld is %lld\n", base, exp, result);

    return 0;
}
