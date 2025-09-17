//====== DATA SECTION ======
.data
    .global UIN
    .align  3       // Align to 2^3 = 8-byte boundary

UIN:
    .quad   36      // 64-bit integer initialized to 36

//====== TEXT SECTION ======
.text
    .global lab03b
    .type   lab03b, %function

//--------------------------------------------------------------------
// Function: lab03b
// Description: Increments the global variable UIN 6 times in a loop.
// Parameters: None
// Return: x0 - The final value of UIN.
//--------------------------------------------------------------------
lab03b:
    // Load the address of the global variable UIN into register x1
    adr     x1, UIN

    // Initialize a loop counter (i) in register x0 to 0
    mov     x0, #0

loop_inc_uin:
    // Load the current value of UIN from memory into register x2
    ldr     x2, [x1]

    // Increment the value
    add     x2, x2, #1

    // Store the new, incremented value back into UIN in memory
    str     x2, [x1]

    // Increment the loop counter
    add     x0, x0, #1

    // Compare the loop counter to 6
    cmp     x0, #6

    // If the counter is not equal to 6, branch back to the start of the loop
    b.ne    loop_inc_uin

    // Prepare the return value. The final value of UIN is in x2.
    // The return value must be in x0.
    mov     x0, x2

    // Return from the function
    ret
