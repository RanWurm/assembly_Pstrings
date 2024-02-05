.extern printf
.extern scanf
.extern srand

.section .rodata
format_printf_enter_seed:   .string "Enter configuration seed: \n"
guess_print_fmt:            .string "What is your guess?\n"
incorrect_print_fmt:        .string "Incorrect.\n"
game_lost_print_fmt:        .string "Game Over, you lost :(. ther correct answer was %d\n"
game_won_print_fmt:         .string "Congratz! You won!\n"
scanf_fmt_int:              .string "%d"


.section .data
user_input:                 .long 0
random_number:              .quad 0
counter:                    .long 0
.text
.global start
.type start, @function

start:
    pushq   %rbp            #saving the old frame pointer.
    movq    %rsp, %rbp      #creating the new frame pointer.

    movq    $format_printf_enter_seed, %rdi
    xorq    %rax, %rax
    call    printf

    movq    $scanf_fmt_int, %rdi
    movq    $user_input, %rsi
    xorq    %rax, %rax
    call    scanf



    #make edi = 0
    movq    user_input, %rdi
    call    srand
    #random number in rax
    call    rand
    #modulo part
    movq    $user_input,   %rdi
    movq    $10,  %rbx
    xorq    %rdx, %rdx
    divq    %rbx   #random number is in rdx

    movq    %rdx, random_number
    movq    random_number, %r10

    #counter is in r9
    movq    $0x5, counter


.loop:
    cmpq    $0x0, counter
    je      .lost

    movq    $guess_print_fmt, %rdi
    xorq    %rax, %rax
    call    printf

    xorq    %rdi, %rdi
    movq    $scanf_fmt_int, %rdi
    movq    $user_input, %rsi
    xorq    %rax, %rax
    call    scanf

    movq    random_number, %r10
    cmpq    %rsi, %r10
    je      .win

    jmp     .wrong



.next:
    sub     $0x1, counter
    jmp     .loop




.lost:
    movq    $game_lost_print_fmt, %rdi
    movq    random_number, %rsi
    xorq    %rax, %rax
    call    printf
    jmp     .finish

.wrong:
    movq    $incorrect_print_fmt, %rdi
    xorq    %rax, %rax
    call    printf
    jmp     .next

.win:
    movq    $game_won_print_fmt, %rdi
    movq    random_number, %rsi
    xorq    %rax, %rax
    call    printf
    jmp     .finish

.finish:
    xorq   %rax, %rax
    movq    %rbp, %rsp      #restoring the old stack pointer.
    popq    %rbp            #restoring the old frame pointer.
    ret