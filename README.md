### Introduction

This repository contains the code and the output for a coding exercise.  To generate new input, run the following:

```
bundle install
rake run
```

You will find the output file under `./lib/output/yesware-output.txt`.  The app expects to find the input file under
`./lib/input/yesware-test-data-v1.txt`, but you can specify a different path by adding the argument specifying `INPUT_FILE_PATH`  
to `rake run`.  

Moreover, you can also set the number of names in the list of completely unique names using the
`UNIQUE_NAMES_LIST_LENGTH` argument.  You can also set where you want the output to be generated with the `OUTPUT_FILE_PATH`
argument.

For example, you could run `rake run INPUT_FILE_PATH='./input.txt' OUTPUT_FILE_PATH='./output.txt' UNIQUE_NAMES_LIST_LENGTH=10` to
set the input file to be a file name `input.txt`in the root directory, the output file to be `output.txt` in that same directory,
and the list of completely unique names to `10`.  
