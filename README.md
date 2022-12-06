# Advent of Code 2021

25 different languages Challenge. Goals for each language: learn/remember the basics, define and use a function.

Day | Language                         | Year | Used b4            | Installed          | Comment
----|----------------------------------|------|--------------------|--------------------|------------------------------------
01  | [Bash](#01-bash)                 | 1989 | :heavy_check_mark: | :heavy_check_mark: | The default Linux Shell, a bit ugly
02  | [Assembly](#02-assembly)         | 1947 | :heavy_check_mark: | :x:                | Remembered the pain of jumping
03  | [Fortran](#03-fortran)           | 1957 | :x:                | :heavy_check_mark: | Used WSL on VSCode Remote Shell
04  | [SQL](#04-sql)                   | 1974 | :heavy_check_mark: | :heavy_check_mark: | Hold my tables
05  | [Visual Basic](#05-visual-basic) | 1991 | :x:                | :x:                | So my father used Visual Basic
06  | [Pascal](#06-pascal)             | 1970 | :x:                | :x:                | Actually decent, except putting ;
07  | ???????


...

Old ones? Or new ones? Or some of both?

Old: Lisp, Algol, Cobol, Ada

Middle: Scala

New: Elixir, Elm

Others: Lua, Powershell

...

- [ ] Day 07: 
- [ ] Day 08: 
- [ ] Day 09: MATLAB
- [ ] Day 10: Rust
- [ ] Day 11: Perl
- [ ] Day 12: Swift
- [ ] Day 13: Ruby
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
bash 01.sh
```

## 02. Assembly
Has routines and operations on registers.
Needs quite a lot of jumps, but at least has divison with remainder for modular arithmetic

## 03. Fortran
FORmula TRANslation
The first commercially available language and one of the first high level programming languages, still used today for high performance computing.
```
gfortran 03.f90
./a.out < inputs/03.txt
```

## 04. SQL
Structured Query Language, 'Ess-cue-ell'
```
sed -i 's/-/,/g' inputs/04.txt
mysql --local-infile=1 -u root -p
source 04.sql
```

## 05. Visual Basic
Needed to close a lot of whiles and ifs, but the closing of for was "Next" instead of "End For", WTF Microsoft.
A lot uglier than the relevant programming languages from the same time.


## 06. Pascal
It's actually pretty decent, except for the fact that all the debugging I had to do was put ; almost everywhere (and not everywhere which makes it more painful).
