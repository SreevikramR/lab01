#include <stdio.h>
#include <stdlib.h>

// Define the size of the arrays.
#define SIZE 50000

// Statically allocate the arrays as requested.
// A and B can hold integers within the standard int range.
int A[SIZE];
int B[SIZE];
// C will store sums that can exceed the int range, so use long long.
long long C[SIZE];


int main() {
    // Define the expected checksum value for validation.
    const long long expected_checksum = 41667916675000LL;
    int i, j;

    // --- 1. Initialize Input Arrays ---
    // Initialize A with increasing values and B with decreasing values.
    // C is initialized to zero before the main computation.
    for (i = 0; i < SIZE; i++) {
        A[i] = i;
        B[i] = SIZE - i;
        C[i] = 0;
    }

    // --- 2. Perform Nested Loop Computation ---
    // This is the core of the benchmark. For each element C[i], it calculates
    // the sum of all elements in B from the beginning up to index A[i].
    // Since A[i] = i, this is equivalent to calculating a running sum of B,
    // but in a deliberately inefficient O(n^2) way to stress the CPU.
    for (i = 0; i < SIZE; i++) {
        // The inner sum can become large, so use a long long accumulator.
        long long inner_sum = 0;
        for (j = 0; j <= A[i]; j++) {
            inner_sum += B[j];
        }
        C[i] = inner_sum;
    }

    // --- 3. Calculate Final Checksum ---
    // Sum all the elements of the resulting array C to get a final checksum.
    long long computed_checksum = 0;
    for (i = 0; i < SIZE; i++) {
        computed_checksum += C[i];
    }

    // --- 4. Verify and Output Result ---
    // Print the computed checksum.
    printf("Computed checksum: %lld\n", computed_checksum);

    // Compare the computed checksum with the expected value and report status.
    if (computed_checksum != expected_checksum) {
        fprintf(stderr, "Error: Checksum mismatch!\n");
        fprintf(stderr, "Expected: %lld\n", expected_checksum);
        fprintf(stderr, "Got: %lld\n", computed_checksum);
        // Exit with a non-zero status code to indicate failure.
        return 1;
    }

    printf("Checksum validation successful.\n");

    // Return 0 to indicate successful execution.
    return 0;
}
