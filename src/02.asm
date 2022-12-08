section .bss
    mybyte: resd 1
    first: resd 1
    second: resd 1
    points: resd 4
    points2: resd 4
    number: resb 4
    result: resb 4
    digit: resb 1
    char: resb 1
  
section .text
    global _start


read_byte:
    mov eax, 3
    mov ebx, 0
    mov ecx, mybyte
    mov edx, 1
    int 80h
    ret


printNumber:
    mov edx, 0          ; clear dividend
    mov eax, [number]   ; dividend
    mov ecx, 10         ; divisor

    div ecx
    mov [number], eax   ; Integer division
    mov [digit], edx    ; Remainder

    call printDigit

    mov eax, [number]
    cmp eax, 0
    jnz printNumber

    ret
  

printDigit:
    mov esi, [digit]
    add esi, 48
    mov [char], esi
    call printChar
    ret

printChar:
    mov eax, 4
    mov ebx, 1
    mov ecx, char
    mov edx, 1
    int 80h
    ret


_start:
    mov esi, 0
    mov [points], esi

myloop:
    call read_byte
    mov esi, [mybyte]

    cmp esi, 80 ; Hem llegit totes les línies
    jge loopend

    mov [first], esi

    call read_byte

    call read_byte
    mov esi, [mybyte]
    mov [second], esi

    call read_byte

    mov esi, [points]
    mov eax, [second]
    sub eax, 87
    add esi, eax
    mov [points], esi

    mov esi, [first]
    mov eax, [second]
    sub eax, 20 ; 23 - 3 per evitar negatius
    sub eax, esi

    mov edx, 0
    mov ecx, 3
    div ecx
    mov [number], edx
    mov [result], edx

    mov esi, [result]
    cmp esi, 0
    jz draw

    mov esi, [result]
    cmp esi, 1
    jz win

second_points:
    mov esi, [second]
    sub esi, 88
    mov eax, [points2]
    add eax, esi
    add eax, esi
    add eax, esi
    mov [points2], eax

    mov esi, [first]
    sub esi, 65

    mov eax, [second]
    sub eax, 90
    jz win2

    mov eax, [second]
    sub eax, 88
    jz lose2

aplica2:
    mov edx, 0
    mov eax, esi
    mov ecx, 3
    div ecx
    add edx, 1

    mov esi, [points2]
    add esi, edx
    mov [points2], esi

    jmp myloop

win2:
    add esi, 1
    jmp aplica2

lose2:
    add esi, 2
    jmp aplica2


draw:
    mov esi, [points]
    add esi, 3
    mov [points], esi
    jmp second_points

win: 
    mov esi, [points]
    add esi, 6
    mov [points], esi
    jmp second_points


loopend:

    ;Els números estan al revés, cal girar-los manualment LOL

    mov esi, [points]
    mov [number], esi
    call printNumber
    mov esi, 10
    mov [char], esi
    call printChar

    mov esi, [points2]
    mov [number], esi
    call printNumber

    mov eax, 1
    mov ebx, 0
    int 80h
