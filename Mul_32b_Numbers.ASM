        org     100h

start:

        mov     ax, word[number1 + 2]
        mul     word[number2 + 2]
        mov     bx, ax
        mov     cx, dx

        mov    ax, word[number1]
        mul    word[number2 + 2]
        add    cx, ax
        adc    di, dx

        mov     ax, word[number1 + 2]
        mul     word[number2]
        add     cx, ax
        adc     di, dx

        mov     ax, word[number1]
        mul     word[number2]
        add     di, ax
        adc     si, dx

        ret

number1         dd      1111'1111h
number2         dd      2222'2222h

      ;
      ;                  1111 1111
      ;                  2222 2222
      ;                 ----------
      ;
      ;
      ; ---------------------------
      ;      si    di    cx    bx


