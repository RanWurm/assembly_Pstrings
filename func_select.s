#exersice 1
#315366039  Ran Wurmbrand

section .rodata
invalid_option_print_fmt:         .string "invalid option!\n"
invalid_input_print_fmt:          .string "invalid input!\n"
func_31_print_fmt:                .string "first pstring length: %d, second pstring length: %d \n"
funcs_33_34_print_fmt:            .string "length: %d, string: %s \n"
scanf_fmt_int:                    .string "%d"

.text
.global run_func
.type run_func, @function
//rdi = choice, rsi =&pstr1, rdx=&pstr2

run_func:
    pushq   %rbp            #saving the old frame pointer.
    movq    %rsp,   %rbp    #creating the new frame pointer.

    cmpq    $0x1f,  %rdi
    je      .31

    cmpq    $0x21,  %rdi
    je      .33

    cmpq    $0x22,  %rdi
    je      .34

    jmp     .invalid_option

.31:
    call pstrlen
    jmp  .finish
.33:
    call swapCase
    jmp  .finish
.34:
    pushq   %r12
    pushq   %r13
    pushq   %r14
    movq    %rsi,   %r12    #first struct
    movq    %rdx,   %r13    #second struct
    subq    $8,     %rsp   #for the chars

    movq    $scanf_fmt_int, %rdi
    leaq    -32(%rbp),     %rsi #mov rsi to the top
    xorq    %rax,   %rax
    call    scanf
    #put the first index from scanf in r14
    movq    (%rsp), %r14

    #scan the second int
    movq    $scanf_fmt_int, %rdi
    leaq    -32(%rbp),     %rsi #mov rsi to the top
    xorq    %rax,   %rax
    call    scanf
#   put the second index from scanf in r8
    movq    (%rsp), %r8

#   move the first sizes of structs
    movzx   0(%r12),    %r9  #first pstring len(8->9)
    movzx   0(%r13),    %r10   #second pstring len(9->10)

#   compare all the bad options
    cmpq    $0x0,   %r14    #i<0
    jl      .34_invalid_input
    cmpq    %r14,    %r8    #j<i
    jl      .34_invalid_input
    cmpq    %r14,  %r9        # i > first struct len
    jl      .34_invalid_input
    cmpq    %r14,  %r10     # i > second struct len
    jl      .34_invalid_input
    cmpq    %r8,  %r9           # j > first struct len
    jl      .34_invalid_input
    cmpq    %r8,  %r10            # j > second struct len
    jl      .34_invalid_input

    #store the correct args in registers for the function
    movq    %r12,   %rdi
    movq    %r13,   %rsi
    movq    %r14,   %rdx
    movq    %r8,    %rcx
    #index's are fine
    call    pstrijcpy

    movb    0(%rax),   %r9b
    leaq    1(%rax),   %rdx

    movq    $funcs_33_34_print_fmt,     %rdi
    movzb   %r9b,     %rsi
    xorq    %rax,   %rax
    call    printf

    movb    0(%r13),   %r8b
    leaq    1(%r13),   %rdx

    movq    $funcs_33_34_print_fmt,     %rdi
    movzb   %r8b,     %rsi
    xorq    %rax,   %rax
    call    printf
    jmp     .finish


.invalid_option:
    movq    $invalid_option_print_fmt,    %rdi
    xorq    %rax,   %rax
    call    printf
    jmp     .finish

.34_invalid_input:
    movq    $invalid_input_print_fmt,    %rdi
    xorq    %rax,   %rax
    call    printf

    movb    0(%r12),   %r9b
    leaq    1(%r12),   %rdx

    movq    $funcs_33_34_print_fmt,     %rdi
    movzb   %r9b,     %rsi
    xorq    %rax,   %rax
    call    printf

    movb    0(%r13),   %r8b
    leaq    1(%r13),   %rdx

    movq    $funcs_33_34_print_fmt,     %rdi
    movzb   %r8b,     %rsi
    xorq    %rax,   %rax
    call    printf
    jmp     .34_finish

.34_finish:
    movq    %r13,   %rdx
    movq    %r12,   %rsi
    popq    %r14
    popq    %r13
    popq    %r12
    addq    $8,     %rsp

.finish:
    movq    %rbp, %rsp      #restoring the old stack pointer.
    popq    %rbp            #restoring the old frame pointer.
    ret
