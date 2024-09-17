#exersice 1
#Ran Wurmbrand

.data
.section .rodata
invalid_option_print_fmt:         .string "invalid input!\n"
func_31_print_fmt:                .string "first pstring length: %d, second pstring length: %d\n"
funcs_33_34_print_fmt:            .string "length: %d, string: %s \n"
scanf_fmt_int:                    .string "%d"

.text
.global pstrlen
.type pstrlen,  @function
pstrlen:
    pushq   %rbp            #saving the old frame pointer.
    movq    %rsp,   %rbp      #creating the new frame pointer.

    movq    %rsi,   %rax
    xorq    %r8,   %r8
    movb    0(%rax),   %r8b

    movq    %rdx,   %rax
    xorq    %r10,   %r10
    movb    0(%rax),    %r10b

    movq    $func_31_print_fmt,   %rdi
    movq    %r8,   %rsi
    movq    %r10,   %rdx

    xorq    %rax,   %rax
    call    printf

    movq    %rbp, %rsp      #restoring the old stack pointer.
    popq    %rbp            #restoring the old frame pointer.
    ret

.global swapCase
.type swapCase,  @function
swapCase:

    pushq   %rbp            #saving the old frame pointer.
    movq    %rsp,   %rbp      #creating the new frame pointer.
    pushq   %r14
    movq    %rdx,   %r14
    pushq   %r15
    movq    $0x1,    %r15
    jmp     .loop_1

.loop_2:

    subq    $0x1,   %r15
    movq    %r14,   %rsi
    xorq    %r9,    %r9
    xorq    %r8,    %r8
    xorq    %rax,    %rax

.loop_1:
    #puts number is is r8
    movq    %rsi,   %rax
    xorq    %r8,    %r8
    movzx   0(%rax),   %r9
    leaq    1(%rax),   %r8

.33_loop:
#reads byte from string and put it in cl
    movzx   (%r8),    %rcx

    cmpb    $0x0,   %cl
    je      .33_finish

    cmpb    $0x5A,  %cl
    jle     .33_capital_to_small

    cmpb    $0x7A,  %cl
    jle     .33_small_to_capital
    jmp     .33_next

.33_capital_to_small:
    cmpb    $0x41,  %cl
    jl      .33_next

    addb    $0x20,  (%r8)
    jmp     .33_next

.33_small_to_capital:
    cmpb    $0x61,  %cl
    jl      .33_next

    subb    $0x20,  (%r8)
    jmp     .33_next
.33_next:
    incq    %r8
    jmp     .33_loop

.33_finish:
    leaq    1(%rsi),    %r8
    movq    $funcs_33_34_print_fmt,     %rdi
    movq    %r9,    %rsi
    movq    %r8,  %rdx
    call    printf
    cmpq    $0x1,   %r15
    je      .loop_2

    popq    %r15
    movq    %r14,   %rdx
    popq    %r14
    movq    %rbp, %rsp      #restoring the old stack pointer.
    popq    %rbp            #restoring the old frame pointer.
    ret

.global pstrijcpy
.type pstrijcpy,  @function
pstrijcpy:

    pushq   %rbp            #saving the old frame pointer.
    movq    %rsp,   %rbp      #creating the new frame pointer.
    movq    %rdi,   %r9

    movq    $0,    %r8
    incq    %rdi
    incq    %rsi

.inc_to_i_loop:
    cmpq    %r8,    %rdx
    je      .cpy_loop
    incq    %rdi
    incq    %rsi
    add     $1,     %r8
    jmp     .inc_to_i_loop

.cpy_loop:
    cmpq    %r8,    %rcx
    jl      .34_finish

    movb    (%rsi),  %al
    movb    %al,    (%rdi)
    incq    %rsi
    incq    %rdi
    add     $1, %r8
    jmp     .cpy_loop

.34_finish:
    movq    %r9,     %rax
    movq    %rbp, %rsp      #restoring the old stack pointer.
    popq    %rbp            #restoring the old frame pointer.
    ret
