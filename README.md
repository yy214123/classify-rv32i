# Assignment 2: Classify
This project is part of the NCKU CSIE Computer Architecture course. It focuses on implementing core mathematical functions and file operations using only the RV32I instruction set of the RISC-V architecture. The goal is to enhance understanding of low-level operations and improve efficiency in RISC-V programming. 
___
## Setup Instructions
### 1. Download Required Tools
Run the following command to download necessary tools:
```shell
$ bash tools/download_tools.sh
```
### 2. Start the Venus Simulator
Run the simulator using:
```shell
$ java -jar tools/venus.jar . -dm
```
### 3. Mount Local Files
In the Venus web terminal, execute:
```shell
$ mount local labs
```
> In your browser, you may see a prompt saying Key has been shown in the Venus mount server! Please copy and paste it into here.. You should be able to see a key in the most recent line of your local terminal output; just copy and paste it into the dialog.

For more detailed steps and troubleshooting, please refer to [Lab 3: RISC-V, Venus](https://cs61c.org/fa24/labs/lab03/).<br>
___
## Part A - Mathematical Functions
### Task 1: ReLU
> [commit 51048b5](https://github.com/sysprog21/classify-rv32i/commit/51048b50b624bff1240d0175474fbf65430f262a)
### Task 2: ArgMax
> [commit 6bd7b55](https://github.com/sysprog21/classify-rv32i/commit/6bd7b552d2649b8a6bfb57631963a1e0809d63a9)
### Task 3.1: Dot Product
> [commit cecbee4](https://github.com/sysprog21/classify-rv32i/commit/cecbee4413d149fe70917b289c46cacd6cb91165)<br> 
> According to the assignment requirements：<br> 
`you must use only RV32I instructions; instructions from the M extension are not allowed.`<br> 
Therefore, I used repeated addition and subtraction to perform the multiplication operation in the dot product calculation.


When I conducted the tests, I found that some test cases failed to pass:<br>
| Test Case                | Status  |
|--------------------------|---------|
| test_abs_minus_one       | ✅ Pass |
| test_abs_one             | ✅ Pass |
| test_argmax_invalid_n    | ✅ Pass |
| test_chain_1             | ❌ Fail |
| test_classify_3_print    | ❌ Fail |

#### Debugging Dot Product (Task 3.1)
**Problem**: The initial implementation of the dot product used elements of the second vector as the loop count. If any element was zero, the loop failed, causing incorrect results.

**Debugging Process**:
1. Added additional test cases where elements in the second vector included zeros.
2. Analyzed the loop logic and identified that zero values caused premature loop termination.

**Solution**:
Refactored the loop to handle zero elements correctly, ensuring that all test cases pass. The updated logic can be found in [commit 765ecf1](https://github.com/sysprog21/classify-rv32i/commit/765ecf1181967abf3afeb5d860e6af77a6c4f60a).


### Task 3.2: Matrix Multiplication
> [commit 61b1015](https://github.com/sysprog21/classify-rv32i/commit/61b10150d79e68f05a07f9b357c97941152e0af6)
___
## Part B - File Operations
### Task 1: Read Matrix
> [commit c818213](https://github.com/sysprog21/classify-rv32i/commit/c818213c36a87cb28799c8b53572adfa6b94ce06)
### Task 2: Write Matrix
> [commit 0c66e48](https://github.com/sysprog21/classify-rv32i/commit/0c66e48faa65c6e65d96dc27b5dda3f6f2922a24)
### Task 3: Classification
> [commit 25eea7c](https://github.com/sysprog21/classify-rv32i/commit/25eea7c68a7cc3baffcfea392b697f0f748b3bb6)
___
### TODO：Improve performance

* Current Issue: The repeated addition/subtraction approach for multiplication causes excessive looping.
* Proposed Solution: Optimize loop structure and investigate alternative implementations.
