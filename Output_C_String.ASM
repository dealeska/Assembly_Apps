        org     100h

start:

        mov     di, output3
        mov     cl, 0
@@:
        cmp     [di], 0h
        je      @F
        mov     ah, 02h
        mov     dl, [di]
        int     21h
        add     di, 1
        jmp     @B

@@:

        mov     ax, 0C08h
        int     21h
        test    al, al
        je      .End
        mov     ah, 08h
        int     21h

.End:
        ret

output3  db    'Eurovision',0



