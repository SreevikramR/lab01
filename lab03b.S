    .section .data
    .align 8                  // Align to 8 bytes for a quad word
UIN: 
    .quad 15                  // Replace 15 with the sum of digits of your UIN

    .section .text
    .global increment_UIN     // Make this callable from C

increment_UIN:
    // Prologue (if needed, but minimal since we just use registers)
    
    MOV     X0, #0            // i = 0

loop_start:
    CMP     X0, #5            // Compare i with 5
    BGT     loop_end           // if i > 5, exit loop

    // Load current UIN value
    LDR     X1, =UIN          // Load address of UIN
    LDR     X2, [X1]          // Load UIN value into X2

    ADD     X2, X2, #1        // UIN = UIN + 1

    STR     X2, [X1]          // Store updated value back to UIN

    ADD     X0, X0, #1        // i = i + 1
    B       loop_start         // Jump back to start of loop

loop_end:
    RET                        // Return to caller
