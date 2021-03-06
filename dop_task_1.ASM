        org     100h

start:
        push    message
        call    WriteSmth

        push    newLine
        call    WriteSmth

        call    ReadName

        push    newLine
        call    WriteSmth

        push    name
        push    "$"
        call    AddSymbol

        push    hello
        call    WriteSmth

        push    name + 2
        call    WriteSmth

        mov     ax, 0C08h
        int     21h

        ret

;==========================================
WriteSmth:

        push    bp
        mov     bp, sp

        mov     ah, 09h
        mov     dx, [bp + 4]
        int     21h

        mov     sp, bp
        pop     bp

        ret      2
;==========================================
ReadName:

        push    bp
        mov     bp, sp

        mov     ah, 0ah
        mov     dx, name
        int     21h

        mov     sp, bp
        pop     bp

        ret
;==========================================
AddSymbol:

        push    bp
        mov     bp, sp

        mov     si, [bp + 6] ;������� ����� name        mov
        movzx   bx, [si + 1] ;�������� �������� �����
        mov     ax, [bp + 4] ;������� "$"
        mov     [si + 2 + bx], al ;������ ����� � ����� ������

        mov     sp, bp
        pop     bp

        ret     4
;==========================================

message         db      "Enter$"
name            db      20,0,18 dup (?)
hello           db      "Hello, $"
newLine         db      10, 13, 24h