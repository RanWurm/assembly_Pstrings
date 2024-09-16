# Assembly Language Project

## Overview
This project includes a variety of programs written in Assembly language, demonstrating operations like random number generation, string manipulation, and input validation. Each file serves a different function, which are detailed below.

### Files and Functions
- **func_select.s**: Implements multiple string manipulation functions and handles different user inputs based on function selection.
- **main.c**: Entry point that calls the `start()` function.
- **main.s**: Handles the main game logic, where a user guesses a random number within a certain range.
- **pstring.s**: Provides functions such as `pstrlen` for calculating string length and `swapCase` for changing the case of characters within a string.
- **start.s**: Initiates the game by accepting a seed input from the user and generating a random number based on that seed.

## Prerequisites
- An assembler like NASM.
- A linker such as LD.
- A Unix-like environment to run the scripts.

## Compilation and Execution
To compile and run the project, follow these steps:

1. **Compile the Assembly Files:**
    ```bash
    nasm -f elf64 -o func_select.o func_select.s
    nasm -f elf64 -o main.o main.s
    nasm -f elf64 -o pstring.o pstring.s
    nasm -f elf64 -o start.o start.s
    ```

2. **Compile the C File:**
    ```bash
    gcc -c main.c -o main.o
    ```

3. **Link the Object Files:**
    ```bash
    ld -o program main.o func_select.o pstring.o start.o
    ```

4. **Run the Program:**
    ```bash
    ./program
    ```

## Functionality
- **Guess the Number Game:** Start the game by entering a seed. The program will then prompt you to guess numbers until you either win by guessing the correct number or lose by running out of attempts.

- **String Manipulation:** Depending on the input option selected, you can manipulate strings by calculating their lengths, copying substrings, or changing the case of their characters.

## Contributions
Feel free to fork this project and contribute to enhancing its functionality or improving the codebase.

## License
This project is open-source and available under the [MIT License](LICENSE).
