# Assignment 2: Classify
After cloning this project, the first step is to execute the following:
```shell
$ bash tools/download_tools.sh

Downloading Venus...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11.0M  100 11.0M    0     0  2019k      0  0:00:05  0:00:05 --:--:-- 2790k
Downloaded Venus!
```
Next, run the command:
```shell
$ java -jar tools/venus.jar . -dm
```
and open [Venus](https://venus.cs61c.org/) In the Venus web terminal, run:
```shell
$ mount local labs
```
> In your browser, you may see a prompt saying Key has been shown in the Venus mount server! Please copy and paste it into here.. You should be able to see a key in the most recent line of your local terminal output; just copy and paste it into the dialog.

For more detailed steps and troubleshooting, please refer to [Lab 3: RISC-V, Venus](https://cs61c.org/fa24/labs/lab03/).<br>
___
This project corresponds to [Assignment 2](https://hackmd.io/@sysprog/2024-arch-homework2) of the Computer Architecture course offered by NCKU CSIE. It is divided into two main parts:<br> 
* **Part A - Mathematical Functions**
* **Part B - File Operations**

### Part A - Mathematical Functions
#### Task 1: ReLU
> [commit 51048b5](https://github.com/sysprog21/classify-rv32i/commit/51048b50b624bff1240d0175474fbf65430f262a)
#### Task 2: ArgMax
> [commit 6bd7b55](https://github.com/sysprog21/classify-rv32i/commit/6bd7b552d2649b8a6bfb57631963a1e0809d63a9)
#### Task 3.1: Dot Product
> [commit cecbee4](https://github.com/sysprog21/classify-rv32i/commit/cecbee4413d149fe70917b289c46cacd6cb91165)<br> 
> According to the assignment requirements：<br> 
`you must use only RV32I instructions; instructions from the M extension are not allowed.`<br> 
Therefore, I used repeated addition and subtraction to perform the multiplication operation in the dot product calculation.

> [commit 765ecf1](https://github.com/sysprog21/classify-rv32i/commit/765ecf1181967abf3afeb5d860e6af77a6c4f60a)<br>
> When I conducted the tests, I found that some test cases failed to pass:<br>
```shell
$ bash test.sh all

test_abs_minus_one (__main__.TestAbs) ... ok
test_abs_one (__main__.TestAbs) ... ok
test_abs_zero (__main__.TestAbs) ... ok
test_argmax_invalid_n (__main__.TestArgmax) ... ok
test_argmax_length_1 (__main__.TestArgmax) ... ok
test_argmax_standard (__main__.TestArgmax) ... ok
test_chain_1 (__main__.TestChain) ... FAIL
test_classify_1_silent (__main__.TestClassify) ... ok
test_classify_2_print (__main__.TestClassify) ... ok
test_classify_3_print (__main__.TestClassify) ... FAIL
...
======================================================================
FAIL: test_chain_1 (__main__.TestChain)

======================================================================
FAIL: test_classify_3_print (__main__.TestClassify)

----------------------------------------------------------------------
Ran 46 tests in 81.339s

FAILED (failures=2)
```
> After performing cross-testing, I identified the issue originating from `dot.s`.<br>
> Although `$ bash test.sh test_dot` passed all test cases,
> the problem lies in the logic design of the repeated subtraction part.<br>
> Specifically, in the loop, I used elements from the second vector as the iteration count.<br>
>  However, this approach causes issues if any element in the second vector is 0. In such cases, the loop behaves incorrectly, leading to errors in the results.

#### Task 3.2: Matrix Multiplication
> [commit 61b1015](https://github.com/sysprog21/classify-rv32i/commit/61b10150d79e68f05a07f9b357c97941152e0af6)

### Part B - File Operations
#### Task 1: Read Matrix
> [commit c818213](https://github.com/sysprog21/classify-rv32i/commit/c818213c36a87cb28799c8b53572adfa6b94ce06)
#### Task 2: Write Matrix
> [commit 0c66e48](https://github.com/sysprog21/classify-rv32i/commit/0c66e48faa65c6e65d96dc27b5dda3f6f2922a24)
#### Task 3: Classification
> [commit 25eea7c](https://github.com/sysprog21/classify-rv32i/commit/25eea7c68a7cc3baffcfea392b697f0f748b3bb6)

### TODO：Improve performance
Currently, repeated addition/subtraction is used to replace mul. While it achieves the intended functionality, it results in excessive looping when handling larger numbers.
