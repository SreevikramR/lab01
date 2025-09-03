import sys

# Define the size of the lists.
SIZE = 50000


def main():
    """
    Main function to run the benchmark.
    """
    # Define the expected checksum value for validation.
    expected_checksum = 41667916675000

    # --- 1. Initialize Input Lists ---
    # Initialize A, B, and C. Using list comprehensions for efficient setup.
    A = list(range(SIZE))
    B = [SIZE - i for i in range(SIZE)]
    C = [0] * SIZE

    # --- 2. Perform Nested Loop Computation ---
    # This is the core of the benchmark. For each element C[i], it calculates
    # the sum of all elements in B from the beginning up to index A[i].
    # This is an O(n^2) operation designed to be computationally intensive.
    for i in range(SIZE):
        inner_sum = 0
        for j in range(A[i] + 1):  # range() is exclusive, so add 1
            inner_sum += B[j]
        C[i] = inner_sum

    # --- 3. Calculate Final Checksum ---
    # Sum all the elements of the resulting list C.
    computed_checksum = sum(C)

    # --- 4. Verify and Output Result ---
    # Print the computed checksum.
    print(f"Computed checksum: {computed_checksum}")

    # Compare the computed checksum with the expected value and report status.
    if computed_checksum != expected_checksum:
        print("Error: Checksum mismatch!", file=sys.stderr)
        print(f"Expected: {expected_checksum}", file=sys.stderr)
        print(f"Got: {computed_checksum}", file=sys.stderr)
        sys.exit(1)

    print("Checksum validation successful.")


if __name__ == "__main__":
    main()
