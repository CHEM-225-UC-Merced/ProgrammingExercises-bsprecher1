#!/usr/bin/perl
#
#   This perl script is used to test Programming Exercises in CHEM 225.
#   Currently, the script is set up to check compilation and unit tests for
#   Programming Excercise 1.
#
#   
#   H. P. Hratchian, 2/6/2025
#   hhratchian@ucmerced.edu
#
#
#   Default the problem number.
#
    $problemNumber = 2;
#
#   Build the test table results array for the requested problem.
#
    if($problemNumber == 2){
#     Programming Exercise 2.
#
#     2-1.
      system("./prgm_02_01.exe input_02_01.txt > .outfiles/out_02_01.out");
      $temp = `diff .outfiles/out_02_01.out .outfiles/out_02_01.txt`;
      if($temp){
        push(@scores,"**FAIL**");
      }else{
        push(@scores,"PASS");
      }
#
#     2-2.
      system("./prgm_02_02.exe input_02_02.txt > .outfiles/out_02_02.out");
      $temp = `diff .outfiles/out_02_02.out .outfiles/out_02_02.txt`;
      if($temp){
        push(@scores,"**FAIL**");
      }else{
        push(@scores,"PASS");
      }
#
#     2-3.
      system("./prgm_02_03.exe input_02_03.txt > .outfiles/out_02_03.out");
      $temp = `diff .outfiles/out_02_03.out .outfiles/out_02_03.txt`;
      if($temp){
        push(@scores,"**FAIL**");
      }else{
        push(@scores,"PASS");
      }
#
#     2-4.
      system("./prgm_02_03.exe input_02_04.txt > .outfiles/out_02_04.out");
      $temp = `diff .outfiles/out_02_04.out .outfiles/out_02_04.txt`;
      if($temp){
        push(@scores,"**FAIL**");
      }else{
        push(@scores,"PASS");
      }
    }elsif($problemNumber == 1){
#     Programming Exercise 1.
#
#     1-1.
      system("printf 'input_01_01.txt\n' | ./prgm_01_01.exe > .outfiles/out_01_01.out");
      $temp = `diff .outfiles/out_01_01.out .outfiles/out_01_01.txt`;
      if($temp){
        push(@scores,"**FAIL**");
      }else{
        push(@scores,"PASS");
      }
#
#     1-2.
      system("printf 'input_01_01.txt\ninput_01_02.txt\n' | ./prgm_01_02.exe > .outfiles/out_01_02.out");
      $temp = `diff .outfiles/out_01_02.out .outfiles/out_01_02.txt`;
      if($temp){
        push(@scores,"**FAIL**");
      }else{
        push(@scores,"PASS");
      }
#
#     1-3.
      system("printf 'input_01_01.txt\ninput_01_02.txt\n' | ./prgm_01_03.exe > .outfiles/out_01_03.out");
      $temp = `diff .outfiles/out_01_03.out .outfiles/out_01_03.txt`;
      if($temp){
        push(@scores,"**FAIL**");
      }else{
        push(@scores,"PASS");
      }
    }else{
      die "\n\nUnknown problem number requested.\n\n";
    }
#
#   Print out result table.
#
    printf "-" x 25 . "\n";
    printf "Test \tPass/Fail\n";
    printf "-" x 25 . "\n";
    foreach (@scores){
      $i += 1;
      printf "%s \t%s\n", $i,$scores[$i-1];
    }
    printf "=" x 25 . "\n";
