; 32bit mode
%include "io.inc"

LOTTO_COUNT equ 6

section .text
global CMAIN
extern _nowtime
extern _randomnum

CMAIN:
   call _now_time  
   PRINT_STRING "몇장을 구매하시겠습니까 ? : "
   GET_DEC 4, [num]
   PRINT_STRING "----------------------------"
   mov edx, 0
   
Rand: ;전체 루프 걸어줌(반복문)
   mov edx, [num]
   cmp [count], edx
   jge D_end
        
   mov ecx, 0
cmain_loop1:
   cmp ecx, LOTTO_COUNT 
   jge cmain_end 
   
   push ecx
   call _random_num ;랜덤 수 가져오기 
   mov [a],eax
   pop ecx
   
   push ecx
   mov ebx,ecx
   call CheckSame ;중복제거
   pop ecx
   
   cmp eax,1
   je cmain_loop1 ;중복제거
   
   mov ebx, [a]
   mov [data+ecx*4],ebx 
   
   inc ecx  
   jmp cmain_loop1
   
cmain_end:
   call ShowData  
   mov ecx,[count]
   inc ecx
   mov [count],ecx
   jmp Rand
   
D_end:   
   ret

;---------------------------------------------

CheckSame:
   mov edx,0 ;edx 초기화
   mov ecx,0 ;ecx 초기화

checksame_loop1:
   cmp ecx,ebx ;값을 비교
   jge checksame_end
   cmp eax, [data+ecx*4];*4를 해주는 이유는 다음 배열을 찾아서 가기 위함임(4byte짜리), 다음칸 주소 알아서 찾아감.
   jne checksame_endif  ;!= 점프해라!
   mov edx,1 
   jmp checksame_end

checksame_endif:
   inc ecx ; 1증가, 다음값 start
   jmp checksame_loop1

checksame_end:
   mov eax, edx   
   ret

;---------------------------------------------
ShowData:
   NEWLINE
   PRINT_STRING msg1
   mov ecx,0 
   
showdata_loop1:
   cmp ecx,LOTTO_COUNT  
   jge show_end
   
   push ecx
   PRINT_DEC 4, [data + ecx*4]
   pop ecx 
   
   cmp ecx, LOTTO_COUNT -1 
   jge show_next
   push ecx
   PRINT_STRING msg2 
   pop ecx 

show_next:
   inc ecx 
   jmp showdata_loop1 

show_end:
   ret
;---------------------------------------------   
section .data 
   msg1 db "Lotto : ",0
   msg2 db ",",0
   count dd 0
   
section .bss;메모리 용량,갯수 확보
   a resd 1 ;4byte
   data resd 6  
   num resd 1;
   
   