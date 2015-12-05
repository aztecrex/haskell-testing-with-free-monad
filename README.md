# Testing an Impure Program Using the Free Monad

## Huh?

This project responds to a question [Sean Shubin](https://github.com/SeanShubin)
posed in a recent hallway discussion: How can you write [this program](https://github.com/SeanShubin/hello)
in Haskell with sufficient test coverage?

Since this seems like something Lambda Jam at [CJ](https://github.com/cjdev) should be able to demonstrate
to our colleagues, we decided to show several approaches and present them to Sean and others wondering about
this Haskell stuff we are doing. This version takes the approach of using the Free monad to separate the pure
and impure parts of the code and test the pure implementation.

## Program Specification 

_(copied from [Sean's Github Project](https://github.com/SeanShubin/hello))_

- input
    - command line argument
    - specifies the name of a file
- behavior
    - load the target from the file in utf-8
    - compose a greeting message that says hello to the target
    - display the greeting message to the console
    - display the time taken in milliseconds to the console


