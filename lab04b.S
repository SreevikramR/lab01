
.globl power

// long long int power(long long int base, long long int exp)
// base in X0, exp in X1
power:
        // Setup stack frame. We need to save X30 (LR) and X0 (base).
        // 16 bytes for 2 registers (8 bytes each).
        SUB SP, SP, 16          // Allocate space on the stack
        STUR X30, [SP, 8]       // Save Link Register
        STUR X0, [SP, 0]        // Save base

        // Check for base case: if (exp == 0)
        CBZ X1, power_base_case

        // Recursive step: my_mul(base, power(base, exp - 1))
        // First, calculate power(base, exp - 1)
        SUB X1, X1, 1           // exp = exp - 1
        BL power                // Recursive call. Result is in X0.

        // Now, X0 = power(base, exp - 1)
        // We need to call my_mul(base, result).
        // Move the result from X0 to X1 for my_mul's second argument.
        MOV X1, X0

        // Restore the original base into X0 for my_mul's first argument.
        LDUR X0, [SP, 0]

        // Call my_mul.
        BL my_mul               // Result of my_mul is in X0.

        // The final result is in X0. Now, we just need to tear down the stack and return.
        B power_return

power_base_case:
        // exp == 0, so return 1.
        MOV X0, 1

power_return:
        // Tear down stack frame and return.
        LDUR X30, [SP, 8]       // Restore Link Register
        ADD SP, SP, 16          // Deallocate stack space
        BR X30                  // Return
