        org 100h

Start:
        call    PrintArr

        push    0
        push    n - 1
        call    QuickSort

        call    NewLine

        call    PrintMas

        mov     ah, 08h
        int     21h
        ret
;=================================================

QuickSort:
        push    bp
        mov     bp, sp
        sub     sp, 6

        mov     ax, [bp + 6]
        mov     [bp - 2], ax
        mov     ax, [bp + 4]
        mov     [bp - 4], ax

        add     ax, [bp + 6]
        mov     bl, 2
        div     bl
        movzx   bx, al
        mov     si, mas
        add     si, bx
        movzx   bx, [si]
        mov     [bp - 6], bx

.Repeat:
.While1:
        mov     bx, [bp - 2]
        mov     si, mas
        movzx   dx, [si + bx]
        mov     di, [bp - 6]
        cmp     dx, di
        jge     .While2
        add     bx, 1
        mov     [bp - 2], bx
        jmp     .While1

.While2:
        mov     bx, [bp - 4]
        mov     si, mas
        movzx   dx, [si + bx]
        mov     di, [bp - 6]
        cmp     dx, di
        jle     @F
        sub     bx, 1
        mov     [bp - 4], bx
        jmp     .While2

@@:
        mov     ax, [bp - 2]
        mov     dx, [bp - 4]
        cmp     ax, dx
        jg      .Next
        mov     si, mas
        add     si, ax
        movzx   ax, [si]
        mov     si, mas
        add     si, dx
        movzx   dx, [si]

        mov     si, mas
        mov     bx, [bp - 2]
        mov     byte[si + bx], dl

        mov     si, mas
        mov     bx, [bp - 4]
        mov     byte[si + bx], al

        mov     si, [bp - 2]
        add     si, 1
        mov     [bp - 2], si
        mov     di, [bp - 4]
        sub     di, 1
        mov     [bp - 4], di
.Next:
        cmp     si, di
        jle     .Repeat

        mov     ax, [bp + 6]
        mov     dx, [bp - 4]
        cmp     ax, dx
        jl      @F
        jmp     .Again1
@@:
        push    ax
        push    dx
        call    QuickSort
.Again1:
        mov     ax, [bp - 2]
        mov     dx, [bp + 4]
        cmp     ax, dx
        jl      @F
        jmp     .Again2

@@:
        push    ax
        push    dx
        call    QuickSort

.Again2:

        mov     sp, bp
        pop     bp

        ret     4

;=================================================
PrintArr:
        push    bp
        mov     bp, sp

        mov     cx, n
        mov     di, 0
.loop:
        movzx   ax, [mas + di]
        push    di
        push    cx
        call    Output
        pop     cx
        pop     di
        add     di, 1
        loop    .loop

        mov     sp, bp
        pop     bp
        ret

;=================================================
Output:
        push    bp
        mov     bp, sp

        xor     di, di
        test    eax, eax
        jne     .Divide
        push    $30
        inc     di
        jmp     .Print

.Divide:
        mov     bx, 10
        mov     cx, 10

.Loop:
        cmp     eax, 0
        je      .Print

        xor     edx, edx
        div     ebx
        add     dx, '0'
        push    dx
        inc     di

.Next:
        loop    .Loop

.Print:
        mov     cx, di
        mov     ah, 02h
@@:
        pop     dx
        int     21h
        loop    @B

        mov     ah, 09h
        mov     dx, Next
        int     21h

        mov     sp, bp
        pop     bp

        ret
;============================================
NewLine:
        push    bp
        mov     bp, sp

        mov     ah, 09h
        mov     dx, newLine
        int     21h

        mov     sp, bp
        pop     bp
        ret

;=============================================


n       =       9
mas     db      100, 79, 102, 255, 134, 65, 109, 67, 58
Next    db      ' ','$'
newLine db      0ah, 0dh, 24h

