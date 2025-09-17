//====== DATA SECTION ======
.data
    .global my_array
    .align  3           // Align to an 8-byte boundary (2^3)

my_array:
    .space  80          // Reserve 80 bytes of space (for 10 quadwords)

//====== TEXT SECTION ======
.text
    .global lab03c
    .type   lab03c, %function

//--------------------------------------------------------------------
// Function: lab03c
// Description: Populates a 10-element array of quadwords.
//              For each element i from 0 to 9, it calculates:
//              my_array[i] = j * 2, where j starts at 7 and increments
//              with each iteration.
// Parameters: None
// Return: x0 - The base address of my_array.
//--------------------------------------------------------------------
lab03c:
    // Initialization
    adr     x1, my_array    // x1 = base address of my_array
    mov     x2, #7          // Initialize variable j (in x2) = 7
    mov     x0, #0          // Initialize loop counter i (in x0) = 0

loop_my_array:
    // Calculate the value to be stored for the current element
    add     x3, x2, x2      // x3 = j * 2

    // Calculate the address of the current array element: &my_array[i]
    // Address = base (x1) + index (x0) * element_size (8 bytes)
    // Note: lsl #3 is equivalent to multiplying by 2^3, or 8.
    add     x4, x1, x0, lsl #3

    // Store the calculated value (x3) into the array at the calculated address (x4)
    str     x3, [x4]        // my_array[i] = x3

    // Update variables for the next iteration
    add     x2, x2, #1      // j++
    add     x0, x0, #1      // i++

    // Loop condition check
    cmp     x0, #10         // Compare i with 10
    b.ne    loop_my_array   // If i != 10, branch back to the start of the loop

    // Prepare the return value. Set x0 to the base address of the array.
    mov     x0, x1

    // Return from the function
    ret
