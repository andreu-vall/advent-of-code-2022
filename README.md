# Advent of Code 2022

As this is my third year doing [Advent of Code](https://adventofcode.com), this time I will try the **25 Different Languages Challenge**, which is solving the problem each day with a different language. I will start with the old and Low-Level ones and work my way up to the ones I'm most comfortable with. The only goal for each language is defining and using a function. This will serve as a programming language history task and to check out interesting languages.

Day Solution            | Language                         | Year | Used b4            | Installed          | Comment
------------------------|----------------------------------|------|--------------------|--------------------|------------------------------------
[01.sh](src/01.sh)      | [Bash](#01-bash)                 | 1989 | :heavy_check_mark: | :heavy_check_mark: | The default Linux Shell, a bit ugly
[02.asm](src/02.asm)    | [Assembly](#02-assembly)         | 1947 | :heavy_check_mark: | :x:                | Remembered the pain of jumping
[03.f90](src/03.f90)    | [Fortran](#03-fortran)           | 1957 | :x:                | :heavy_check_mark: | Used WSL on VSCode Remote Shell
[04.sql](src/04.sql)    | [SQL](#04-sql)                   | 1974 | :heavy_check_mark: | :heavy_check_mark: | Hold my tables
[05.vb](src/05.vb)      | [Visual Basic](#05-visual-basic) | 1991 | :x:                | :x:                | So my father used Visual Basic
[06.pas](src/06.pas)    | [Pascal](#06-pascal)             | 1970 | :x:                | :x:                | Actually decent, except putting ;
[07.scala](src/07.scala)| [Scala](#07-scala)               | 2005 | :x:                | :x:                | Java without ; 
[08.lua](src/08.lua)    | [Lua](#08-lua)                   | 1993 | :x:                | :x:                | Both gangster and slighly painful things
[09.m](src/09.m)        | [MATLAB](#09-matlab)             | 1984 | :x:                | :x:                | A bit restrictive but works
[10.pl](src/10.pl)      | [Perl](#10-perl)                 | 1987 | :x:                | :heavy_check_mark: | Acceptable, but $ and err checking sucks
[11.swift](src/11.swift)| [Swift](#11-swift)               | 2014 | :x:                | :x:                | Pretty bad ngl
[12.rb](src/12.rb)      | [Ruby][#12-ruby)                 | 1995 | :x:                | :x:                | It's actually good but a lot of ends

Left out: Lisp, Algol, Elixir, Powershell

Order subject to change depending on the problem and how I'm feeling

- [ ] Day 13: Rust
- [ ] Day 14: PHP
- [ ] Day 15: Julia
- [ ] Day 16: R
- [ ] Day 17: Go
- [ ] Day 18: Kotlin
- [ ] Day 19: C
- [ ] Day 20: C#
- [ ] Day 21: Javascript
- [ ] Day 22: Java
- [ ] Day 23: Typescript
- [ ] Day 24: C++
- [ ] Day 25: Python


## 01. Bash
Bourne Again SHell. Used for making Scripts
```
bash src/01.sh
```

## 02. Assembly
Has routines and operations on registers.
Needs quite a lot of jumps, but at least has divison with remainder for modular arithmetic

## 03. Fortran
FORmula TRANslation
The first commercially available language and one of the first high level programming languages, still used today for high performance computing.
```
gfortran src/03.f90
./a.out < inputs/03.txt
```

## 04. SQL
Structured Query Language, 'Ess-cue-ell'
```
sed -i 's/-/,/g' inputs/04.txt
mysql --local-infile=1 -u root -p
source src/04.sql
```

## 05. Visual Basic
Needed to close a lot of whiles and ifs, but the closing of for was "Next" instead of "End For", WTF Microsoft.
A lot uglier than the relevant programming languages from the same time.


## 06. Pascal
It's actually pretty decent, except for the fact that all the debugging I had to do was put ; almost everywhere (and not everywhere which makes it more painful).

## 07. Scala
Decent, I like not having to end lines with the ;

## 08. Lua
Getting the length of a string with # is really gangster, but getting a char from an string is really painful. Overall pretty good experience.

## 09. MATLAB
The functions are a bit pants because I can't edit a dictionary inside them, but overall it's decent.

## 10. Perl
```
perl src/10.pl < inputs/10.txt
```

## 11. Swift

## 12. Ruby

