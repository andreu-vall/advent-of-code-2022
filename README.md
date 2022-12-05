# Advent of Code 2021

25 different languages Challenge

Day | Language                 | Year | Used b4 | Installed | Comment
----|--------------------------|------|---------|-----------|--------------------------
01  | [Bash](#01-bash)         | 1989 | Yes     | Yes       | 
02  | [Assembly](#02-assembly) | 1947 | Yes     | No        | Remembered the pain of jumping
03  | [Fortran](#03-fortran)   | 1957 | No      | Yes       | Used wsl on VSCode Remote Shell
04  | [SQL](#04-sql)           | 1974 | Yes     | Yes       |
05  | ????

...
Old ones? Or new ones? Or some of both?
Old: Algol, Pascal, Cobol, Basic, Ada, Lisp
Middle: Scala
New: Elixir, Elm
Others: Lua, Powershell
...

- [x] Day 01: Bash
- [x] Day 02: Assembly
- [x] Day 03: Fortran
- [X] Day 04: SQL
- [ ] Day 05: 
- [ ] Day 06: 
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
The first commercially available language and one of the first high level programming languages, still used today.
```
gfortran 03.f90
./a.out < inputs/03.txt
```

## 04. SQL
Structured Query Language
```
sed -i 's/-/,/g' inputs/04.txt
mysql --local-infile=1 -u root -p
source 04.sql
```
