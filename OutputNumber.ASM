        org     100h

start:

        mov     ax, 2021
        mov     ax, 3745o
        mov     ax, 0111'1110'0101b
        mov     ax, 0x7E5
        mov     ax, $7E5
        mov     ax, -5

        call    Output

        mov     ax, 0C08h
        int     21h
        test    al, al
        je      .End
        mov     ah, 08h
        int     21h

.End:
        ret

;-------------------------------------------------------
Output:
        push    bp
        mov     bp, sp

        xor     di, di
        test    eax, eax
        jne     .Devide
        push    $30
        inc     di
        jmp     .Print

.Devide:
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

        mov     sp, bp
        pop     bp

        ret

