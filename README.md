# Hardware Design
This repository contains my projects from Hardware Design cource
Each Project has a folder, where you can find a projectXX.txt file that contains project description/details

#### Software
* Quartus Prime Lite software (version 16.1)
* ModelSim

#### Hardware
[DE0-Nano](ftp://ftp.altera.com/up/pub/Altera_Material/12.1/Boards/DE0-Nano/DE0_Nano_User_Manual.pdf)
Breadboard

## Project 1: Full Adder

### Project Overview

The purpose of the project was to impliment a binary full adder. That involved several steps that were done using different software and hardware. A schematic design was done in Intel Quartus Prime IDE, then the design was simulated in ModelSim. Then, the correctness of the design was tested with DEO-Nano and implimented with physical hardware pieces (wires, logical gates etc.)

### Learning Objectives

* Create a schematic-based design using the Intel Quartus Prime IDE.
* Simulate a design using ModelSim.
* Upload a digital design to an FPGA to further verify its correctness.
* Implement a logical circuit using a breadboard.
---

## Project 2: Seven Segment Display

### Project Overview

The goal this project was to design a milti-output combinational logic circuit, the seven-segment display. That involved constructing a truth table, constructing Karnaugh maps for optimising for number of logic gates, constructing boolean equations for each output based on the Karnaugh maps and converting those equations into scematics by using Quartus. The pin assigments was done by importing a pin asssignment file. Then, the performance of the decoder (display) was simulated in ModelSim. Once the simulation showed the desired performance, the design was downloaded to DEO-nano. Then, DEO-nano was connected by wires to the display on the breadboard to demonstrate its work.

### Learning Objectives
* Design a multi-output combinational logic circuit.
* Import pin assignments into Quartus using a pin assignment file.
* Learn additional features of ModelSim, including forcing multibit inputs and using different number systems (e.g. Hex) in a waveform.
* Control an external device (a 7-segment display) using the IO pins of an FPGA.
* Gain additional experience working with Quartus and ModelSim.

---

## Project 4: Thunderbird Turn Signal

### Project Overview

I designed a finite state machine in SystemVerilog to control the taillights of a 1965 Ford Thunderbird. There were three lights on each side that operate in sequence to indicate the direction of a turn. The sequence was designed to complete even when the button was released during it. If none of the buttons or both left and right button were pressed in initial states, no lights were turned on.

### Learning Objectives
* Design an FSM, starting with only a textual description of its operation.
* Implement a digital design using the SystemVerilog HDL.
* Write a testbench using the SystemVerilog HDL.
* Gain additional experience in debugging with ModelSim.

---

## Project 5: ALU

### Project Overview

I disigned an ALU for a future microprocessor with 7 operations
- `and`
- `or`
- `+`
- unused (`y` = `carry_out` = `overflow `= `0`, `zero` = `1`)
- `xor`
- `nor`
- `-`
- `slt`

And then I wrote a self-testing testbench that used a vectorvile to verify the correctnes of implemented alu

### Learning Objectives
* Design and implement a combinational circuit using the SystemVerilog HDL.
* Write a self-checking SystemVerilog testbench.
* Read hexadecimal data from a file using SystemVerilog.
* Gain additional experience in debugging with ModelSim.

---

## Project 6: MIPS Assembly Language Programming

### Project Overview

#### Program 1: Gnome Sort

Gnome Sort is a relatively simple sorting algorithm that is so named because it is similar to “how a gnome sorts a line of flower pots.” It’s similar to the well-known insertion sort algorithm.

I wrote a MIPS program that is equivalent to the following C program:
```
int arr_len = 7;
int arr[7] = {20, 52, 8, 17, 25, 3, 20};

void gnome_sort(int *a, int len) {
    int pos = 1;
    while (pos < len) {
        if (a[pos] >= a[pos-1]) {
            pos++;
        } else {
            // swap a[pos] and a[pos-1]
            int tmp = a[pos];
            a[pos] = a[pos-1];
            a[pos-1] = tmp;

            if (pos > 1)
                pos--;
        }
    }
}

void main() {
    gnome_sort(arr, arr_len);
}
```

#### Program 2: Function Calls

I wrote a MIPS program that implements the following C program.
```
int bar(int x, int y) {
    return x & y;
}

int foo(int x) {
    int tmp = bar(x-1, 10);
    return tmp + x;
}

void main() {
    foo(7); // should return 9
}
```
My code is a direct implementation of this program (i.e. without simplifying the C code). This code is saved in a file named calls.s

#### Program 3: System Calls

MIPS has a special syscall instruction meant to allow a program to make an operating system call. The MARS simulator implements a number of system calls, which you can read about [here](http://courses.missouristate.edu/KenVollmar/MARS/Help/SyscallHelp.html).

I implemented the program given below.
```
void main() {
    int *arr = malloc(16); // allocate space for 4 integers
    int i;

    // fill in array with random values, printing out the values as we go
    for (i = 0; i < 4; i++) {
        int x = rand();
        arr[i] = x;
        printf("%d\n",x); // print x followed by a new line
        }

    exit();
}
```
Your MIPS code is saved in a file named syscalls.s.

#### Program 4: Recursive Function Calls (QuickSelect)

The selection problem is stated as: given a (possibly unsorted) array of numbers, return the smallest element in the array. While there are many potential algorithms for solving this problem, the QuickSelect algorithm is fairly elegant and has good average case performance (O(n)). (As the name implies, it is closely related to QuickSort, which may give you a good frame of reference for how the algorithm operates.)

The C code for QuickSelect is given below. QuickSelect relies on the divide-and-conquer strategy, which is implemented using recursion in the code given below.
```
/*
* Group the part of the input array (arr[left...right]) into two sets: one
* set whose values are less than the given pivot, and those that are >= the
* pivot.
*
* @param arr The array to partition.
* @param left The index where we want to start partitioning
* @param right The index where we want to stop partitioning
* @param pivot A pivot point between left and right
* @return The index that divides the two sets that were created.
*/
int partition(int *arr, int left, int right, int pivot) {
    int pivot_val = arr[pivot];

    // move pivot to end
    int tmp = arr[pivot];
    arr[pivot] = arr[right];
    arr[right] = tmp;

    int store_index = left;

    int i;
    for (i = left; i < right; ++i) {
        if (arr[i] < pivot_val) {

            // swap elements at store_index and i
            tmp = arr[store_index];
            arr[store_index] = arr[i];
            arr[i] = tmp;

            store_index++;
        }
    }

    // move pivot to its final place
    tmp = arr[right];
    arr[right] = arr[store_index];
    arr[store_index] = tmp;

    return store_index;
}

/*
* Finds the nth smallest element in a subset of a given array
* (arr[left..right]).
*
* @info We start n at 0, meaning that n = 0 returns the smallest element is
* the array range
*
* @param arr The array to select from
* @param left The index in array where select will start
* @param right The index in array where select will stop
* @param n Which element to return (0 = smallest, 1 = next smallest, ...)
* @return The nth smallest element in arr[left...right]
*/
int select(int *arr, int left, int right, int n) {
    if (left == right)
        return arr[left];

    // pivot will be middle of left and right
    int pivot_index = (left + right)/2;
    pivot_index = partition(arr, left, right, pivot_index);

    if (n == pivot_index)
        return arr[n];
    else if (n < pivot_index)
        return select(arr, left, pivot_index - 1, n);
    else
        return select(arr, pivot_index + 1, right, n);
}
```
I MIPS code is stored in select.s.

### Learning Objectives
* Write programs in the MIPS assembly language.
* Write MIPS code that implements the MIPS function calling protocol described in the course textbook.
* Learn to use the MARS simulator to simulate and debug your MIPS assembly language programs.

---

## Project 7: MIPS Single-Cycle Processor

### Project Overview

For this project I modified a SystemVerilog implementation of a MIPS single-cycle processor to support two new instructions (`ori` and `bne`). Along the way I converted assembly code into machine code and tested that my processor correctly executes a simple program.

4. Assembler Examples:

- Instruction: `ori  $t0, $zero, 0x8000`
- HEX representation: `0x34088000`
- Binary representation: `0011 0100 0000 1000 1000 0000 0000 0000`
- Instruction format: `I-type`
- opcode =` 001101` (opcode for `ori` instruction)
- `rs = 00000 ($zero)`
- `rt = 01000 ($t0 is register 8)`
- immediate = `1000000000000000` (`0x8000` in binary)

- Instruction: `beq  $t0, $t1`, there
- HEX representation: `0x11090005`
- Binary representation: `0001 0001 0000 1001 0000 0000 0000 0101`
- Instruction format: `I-type`
- opcode = `000100` (opcode for `beq` instruction)
- `rs = 01000 ($t0 is register 8)`
- `rt = 01001 ($t1 is register 9)`
- immediate = `0000000000000101`
(‘there’ is 10th instruction in instructions memory
`0 + 4 * 9 = 36 = 0x24` in `hex` (sign extend to `16 bits`) = `0000000000000101`)


- Instruction: `slt  $t3, $t1, $t0`
- HEX representation: `0x0128582A`
- Binary representation: `0000 0001 0010 1000 0101 1000 0010 1010`
- Instruction format: `R-type`
- opcode = `000000` (opcode for all `R-type` instructions)
- `rs = 01001` (`$t1` is register `9`)
- `rt = 01000` (`$t0` is register `8`)
- `rd = 01011` (`$t3` is register `11`)
- `shamt = 00000` (unused for `slt`)
- `funct = 101010` (`slt`)


- Instruction: `j there`
- HEX representation: `0x8000024`
- Binary representation: `0000 1000 0000 0000 0000 0000 0010 0100`
- Instruction format: `J-type`
- opcode = `000010`
- address = `00000000000000000000100100`
(`there` is 10th instruction in instructions memory
`0 + 4 * 9 = 36 = 0x24` in `hex = 0010 0100`, sign extend to `26 bits`)

### Learning Objectives
* Trace the cycle-by-cycle execution of a MIPS program through a single-cycle MIPS processor.
* Convert MIPS assembly code into machine code.
* Use the processor design algorithm to modify an existing processor to support additional instructions.

---

## Project 8: MIPS Pipelined Processor (Part I)

### Project Overview
I built a pipelined MIPS processor using SystemVerilog (without taking care of data or control hazards. This is implemented in `Project 9`). I minimized the impact of control hazards by resolving the branch in the decode stage rather than in the execute stage.

### Learning Objectives
* Trace the cycle-by-cycle execution of a MIPS program through a pipelined MIPS processor.
* Identify data and branch hazards and insert nop instructions to ensure that the correct values are produced by the processor.
* Simulate and debug a complex processor design using ModelSim.

---

## Project 9: MIPS Pipelined Processor (Part II)

### Project Overview
I improved upon the pipelined MIPS processor that I implemented in the last project. The major improvement came in the form of handling both data and branch hazards using hardware rather than software/nop. I used a combination of forwarding, stalls, and flushes to handle hazards. I used Unit Testing to test the project in small parts before running a big test that covered a complex scenarios.

### Learning Objectives
* Trace the cycle-by-cycle execution of a MIPS program through a pipelined MIPS processor with support for forwarding and stalls.
* Modify a pipelined processor to support forwarding and stalling.
* Simulate and debug a complex processor design using ModelSim, using a unit-testing based approach.

---

## Project 10: Dynamic Branch Prediction

### Project Overview
In this project I put the finishing touches on my pipelined MIPS processor. I designed and implemented a branch target buffer for dynamic branch prediction. 

### Learning Objectives
* Design a branch target buffer and use it to implement dynamic branch prediction in a pipelined processor.
* Simulate and debug a complex processor design using ModelSim.
