INCLUDE Irvine32.inc
main EQU start@0
InitialScreen PROTO
EasyLevel PROTO
MediumLevel PROTO
HardLevel PROTO
max = 70

.data
;I/O
outputHandle DWORD 0
inputHandle DWORD 0
bytesWritten DWORD 0
bytesRead DWORD 0
xyPosition COORD <?,?>
;intro
Begin BYTE "Press Enter to START", 0
rule00 BYTE "INTRODUCTION",0
rule01 BYTE "This is a game for more than two people.",0
rule02 BYTE "1 At least one person have to set the question(person A), others have to guess.",0
rule03 BYTE "2 A will have to give a word and three description about the word.",0
rule04 BYTE "3 A will have the right to choose how hard the game will be.",0
rule05 BYTE "4 Easy level will have the first word hint and no time limit.",0
rule06 BYTE "5 Medium level will have no time limit.",0
rule07 BYTE "6 Hard level will have time limit.",0
rule08 BYTE "7 Other will just have to guess the word with the hint given by A.",0
rule09 BYTE "GOOD LUCK.",0
;JUST
welcome00	BYTE  12 DUP(0DBh), 6 DUP(' '), 0DBh, 0DBh, ' ', 22 DUP(0DBh)
welcome01	BYTE  4 DUP(' '), 0DBh, 0DBh, 4 DUP(' '), 0DBh, 0DBh, 6 DUP(' '), 2 DUP(0DBh), ' ', 2 DUP(0DBh), 12 DUP(' '), 0DBh, 0DBh
welcome02	BYTE  4 DUP(' '), 0DBh, 0DBh, 4 DUP(' '), 0DBh, 0DBh, 6 DUP(' '), 2 DUP(0DBh), ' ', 2 DUP(0DBh), 12 DUP(' '), 0DBh, 0DBh
welcome03	BYTE  4 DUP(' '), 0DBh, 0DBh, 4 DUP(' '), 0DBh, 0DBh, 6 DUP(' '), 2 DUP(0DBh), ' ', 2 DUP(0DBh), 12 DUP(' '), 0DBh, 0DBh
welcome04	BYTE  4 DUP(' '), 0DBh, 0DBh, 4 DUP(' '), 0DBh, 0DBh, 6 DUP(' '), 0DBh, 0DBh, ' ', 8 DUP(0DFh), 0DBh, 0DBh, 4 DUP(' '), 0DBh, 0DBh
welcome05	BYTE  4 DUP(' '), 0DBh, 0DBh, 4 DUP(' '), 0DBh, 0DBh, 6 DUP(' '), 0DBh, 0DBh, 9 DUP(' '), 0DBh, 0DBh, 4 DUP(' '), 0DBh, 0DBh
welcome06	BYTE  4 DUP(' '), 0DBh, 0DBh, 4 DUP(' '), 0DBh, 0DBh, 6 DUP(' '), 0DBh, 0DBh, 9 DUP(' '), 0DBh, 0DBh, 4 DUP(' '), 0DBh, 0DBh
welcome07	BYTE  6 DUP(0DBh), 4 DUP(' '), 10 DUP(0DBh), 11 DUP(0DBh), 4 DUP(' '), 0DBh, 0DBh
attributes0 WORD LENGTHOF welcome00 DUP(0Bh)
;GUESS
welcome08	BYTE  ' ', 8 DUP(0DBh), '  ', 2 DUP(0DBh), 6 DUP(' '), 2 DUP(0DBh), 2 DUP(' '), 9 DUP(0DBh), '  ', 9 DUP(0DBh), '  ', 9 DUP(0DBh) 
welcome09	BYTE  2 DUP(0DBh), 9 DUP(' '), 2 DUP(0DBh), 6 DUP(' '), 2 DUP(0DBh), ' ', 2 DUP(0DBh), 9 DUP(' '), 2 DUP(0DBh), 9 DUP(' '), 2 DUP(0DBh)
welcome10	BYTE  2 DUP(0DBh), 9 DUP(' '), 2 DUP(0DBh), 6 DUP(' '), 2 DUP(0DBh), ' ', 2 DUP(0DBh), 9 DUP(' '), 2 DUP(0DBh), 9 DUP(' '), 2 DUP(0DBh)
welcome11	BYTE  2 DUP(0DBh), 9 DUP(' '), 2 DUP(0DBh), 6 DUP(' '), 2 DUP(0DBh), ' ', 2 DUP(0DBh), 9 DUP(' '), 2 DUP(0DBh), 9 DUP(' '), 2 DUP(0DBh)
welcome12	BYTE  2 DUP(0DBh), 2 DUP(' '), 5 DUP(0DBh), '  ', 2 DUP(0DBh), 6 DUP(' '), 2 DUP(0DBh), ' ', 2 DUP(0DBh), 8 DUP(0DFh), ' ', 8 DUP(0DFh), 0DBh, 0DBh, ' ', 8 DUP(0DFh), 0DBh, 0DBh 
welcome13	BYTE  2 DUP(0DBh), 6 DUP(' '), 2 DUP(0DBh), ' ', 2 DUP(0DBh), 6 DUP(' '), 2 DUP(0DBh), ' ', 2 DUP(0DBh), 17 DUP(' '), 2 DUP(0DBh), 9 DUP(' '), 2 DUP(0DBh)
welcome14	BYTE  2 DUP(0DBh), 6 DUP(' '), 2 DUP(0DBh), ' ', 2 DUP(0DBh), 6 DUP(' '), 2 DUP(0DBh), ' ', 2 DUP(0DBh), 17 DUP(' '), 2 DUP(0DBh), 9 DUP(' '), 2 DUP(0DBh)
welcome15	BYTE  ' ', 8 DUP(0DBh), 3 DUP(' '), 8 DUP(0DBh), 3 DUP(' '), 9 DUP(0DBh), ' ', 9 DUP(0DBh), '  ', 9 DUP(0DBh)
attributes1 WORD LENGTHOF welcome08 DUP(0Dh)
;GAME HINT
instruct00 BYTE "Please enter the first description. (under 50 words)"
ienter00   BYTE max+1 DUP(?)
instruct01 BYTE "Please enter the second description.(under 50 words)"
ienter01   BYTE max+1 DUP(?)
instruct02 BYTE "Please enter the third description. (under 50 words)"
ienter02   BYTE max+1 DUP(?)
instruct03 BYTE "Please enter the WORD. (under 30 words)"
ienter03   BYTE max-19 DUP(?)
ienter03L  BYTE ?
;level
level	   BYTE "Enter the level. (1:easy,2:medium,3:hard)"
level2	   BYTE "Invalid value Enter Again (1:easy,2:medium,3:hard)"
lenter	   SDWORD ?
;GAME
Gline00	   BYTE "The three descriptions given are: "
Gline01	   BYTE "Your answer is:"
answer	   BYTE max-19 DUP(?)
answerL	   BYTE ?
Clear	   BYTE "Status : Congratulation !"
TryAgain   BYTE	"Status : Oops ! Try Again" 
Think	   BYTE "You have only 10 second to think !"
attributes2 WORD LENGTHOF Clear DUP(0F4h)
attributes3 WORD LENGTHOF TryAgain DUP(0F8h)
PlayAgain	BYTE "Do you want to play again?  y/others"
PlayAgain01 BYTE "Do you want to play again? n"
Thank00		BYTE "Thanks For Playing!"
Thank01		BYTE "Main Program  : fv1230."
Thank02		BYTE "Art consultant : howardgood88."

.code

InitialScreen PROC			;welcome page
 
	;JUST
	mov xyPosition.x, 24
	mov xyPosition.y, 5
	mov bx, xyPosition.y
	;color
	push ecx
	mov ecx, 8
L1:	push ecx
	INVOKE WriteConsoleOutputAttribute,
      outputHandle,
      ADDR attributes0,
      LENGTHOF welcome00,
      xyPosition,
      ADDR bytesWritten
	inc xyPosition.y
	pop ecx
	loop L1
	pop ecx
	mov xyPosition.y, bx
	;print word
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR welcome00,
      LENGTHOF welcome00,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR welcome01,
      LENGTHOF welcome01,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR welcome02,
      LENGTHOF welcome02,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR welcome03,
      LENGTHOF welcome03,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR welcome04,
      LENGTHOF welcome04,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR welcome05,
      LENGTHOF welcome05,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR welcome06,
      LENGTHOF welcome06,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR welcome07,
      LENGTHOF welcome07,
      xyPosition,
      ADDR bytesWritten
	  
	;GUESS
	add xyPosition.y, 3
	add xyPosition.x, 10
	mov bx, xyPosition.y
	;color
	push ecx
	mov ecx, 8
L2:	push ecx
	INVOKE WriteConsoleOutputAttribute,
      outputHandle,
      ADDR attributes1,
      LENGTHOF welcome08,
      xyPosition,
      ADDR bytesWritten
	inc xyPosition.y
	pop ecx
	loop L2
	pop ecx
	mov xyPosition.y, bx
	;print word
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR welcome08,
      LENGTHOF welcome08,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR welcome09,
      LENGTHOF welcome09,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR welcome10,
      LENGTHOF welcome10,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR welcome11,
      LENGTHOF welcome11,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR welcome12,
      LENGTHOF welcome12,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR welcome13,
      LENGTHOF welcome13,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR welcome14,
      LENGTHOF welcome14,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR welcome15,
      LENGTHOF welcome15,
      xyPosition,
      ADDR bytesWritten	
	add xyPosition.y, 5
	mov xyPosition.x, 46
	
	;Press Enter to START
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR Begin,
      LENGTHOF Begin,
      xyPosition,
      ADDR bytesWritten	
	add xyPosition.x, 20
	INVOKE SetConsoleCursorPosition, outputHandle, xyPosition
	call ReadChar
	.IF ax == 1C0Dh 		; press ENTER to continue
		ret
	.ENDIF
	ret
InitialScreen ENDP

Introduction PROC			;rule page

	mov eax, 15+9*16
	CALL SetTextColor
	call ClrScr
	mov xyPosition.y, 6
	mov xyPosition.x, 50
	
    INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR rule00,
      LENGTHOF rule00,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	inc xyPosition.y
	mov xyPosition.x, 20
    INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR rule01,
      LENGTHOF rule01,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR rule02,
      LENGTHOF rule02,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR rule03,
      LENGTHOF rule03,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR rule04,
      LENGTHOF rule04,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR rule05,
      LENGTHOF rule05,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR rule06,
      LENGTHOF rule06,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR rule07,
      LENGTHOF rule07,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR rule08,
      LENGTHOF rule08,
      xyPosition,
      ADDR bytesWritten	
	inc xyPosition.y
	inc xyPosition.y
	mov xyPosition.x, 51
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR rule09,
      LENGTHOF rule09,
      xyPosition,
      ADDR bytesWritten	
	Add xyPosition.y, 2
	mov xyPosition.x, 43
	INVOKE SetConsoleCursorPosition, outputHandle, xyPosition
	call WaitMsg
	ret

Introduction ENDP

Scenes1 PROC USES eax ebx ecx edx
	
	Call ClrScr
	;first hint
	mov xyPosition.x, 16
	mov xyPosition.y, 5
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR instruct00,
      LENGTHOF instruct00,
      xyPosition,
      ADDR bytesWritten	
	mov dh, 6
	mov dl, 16
	Call Gotoxy
	mov edx, OFFSET ienter00
	mov ecx, max
	Call ReadString
	add xyPosition.y, 3
	;second hint
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR instruct01,
      LENGTHOF instruct01,
      xyPosition,
      ADDR bytesWritten	
	mov dh, 9
	mov dl, 16
	Call Gotoxy
	mov edx, OFFSET ienter01
	mov ecx, max
	Call ReadString
	add xyPosition.y, 3
	;third hint
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR instruct02,
      LENGTHOF instruct02,
      xyPosition,
      ADDR bytesWritten	
	mov dh, 12
	mov dl, 16
	Call Gotoxy
	mov edx, OFFSET ienter02
	mov ecx, max
	Call ReadString
	add xyPosition.y, 3
	;enter word
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR instruct03,
      LENGTHOF instruct03,
      xyPosition,
      ADDR bytesWritten	
	mov dh, 15
	mov dl, 16
	Call Gotoxy
	mov edx, OFFSET ienter03
	mov ecx, max
	Call ReadString
	mov ienter03L, al
	mov bl, 16
EL:	add xyPosition.y, 2
	;enter level
	.IF bl == 16
		add xyPosition.y, 1
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,
		  ADDR level,
		  LENGTHOF level,
		  xyPosition,
		  ADDR bytesWritten	
	.ELSE
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,
		  ADDR level2,
		  LENGTHOF level2,
		  xyPosition,
		  ADDR bytesWritten	
	.ENDIF
	add bl, 2
	mov dh, bl
	mov dl, 16
	Call Gotoxy
	Call ReadChar
	Call WriteChar
	.IF ax == 0231h ;easy(1)
		INVOKE EasyLevel
		ret
	.ENDIF
	.IF ax == 0332h ;medium(2)
		INVOKE MediumLevel
		ret
	.ENDIF
	.IF ax == 0433h ;hard(3)
		INVOKE HardLevel
		ret
	.ENDIF
	jmp EL
	
Scenes1 ENDP

EasyLevel PROC 

	mov eax, 2+15*16
	CALL SetTextColor
	Call ClrScr
	mov xyPosition.x, 10
	mov xyPosition.y, 5
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR Gline00,
      LENGTHOF Gline00,
      xyPosition,
      ADDR bytesWritten
	add xyPosition.y, 2
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR ienter00,
      LENGTHOF ienter00,
      xyPosition,
      ADDR bytesWritten
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR ienter01,
      LENGTHOF ienter01,
      xyPosition,
      ADDR bytesWritten
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR ienter02,
      LENGTHOF ienter02,
      xyPosition,
      ADDR bytesWritten
	add xyPosition.y, 2
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR Gline01,
      LENGTHOF Gline01,
      xyPosition,
      ADDR bytesWritten

	mov dh, 12
	mov dl, 10
	Call Gotoxy
	movzx ax, ienter03
	Call WriteChar
	movzx ecx, ienter03L ;the length of the word provide by A
	dec ecx
	mov ax, 0C5Fh
PD:	Call WriteChar		 ;print '_'
	loop PD
	mov bl, 13
Ans:mov dh, bl			 ;enter answer
	mov dl, 10
	Call Gotoxy
	mov edx, OFFSET answer
	movzx ecx, ienter03L+1
	Call ReadString
	mov answerL, al		  ;answer LENGTH
	movzx ecx, ienter03L  ;compare answer
	push ebx
	push edx
	push esi
	push edi
	mov esi, BYTE PTR OFFSET ienter03
	mov edi, BYTE PTR OFFSET answer
Check:
	mov bl, [esi]
	mov dl, [edi]
	cmp bl, dl
	je equal
	jmp ENDE
equal:
	cmp al, ienter03L		 ;check for over entered
	jne ENDE 
	inc esi
	inc edi
	loop Check
	pop edi
	pop esi
	pop edx
	pop ebx
	mov xyPosition.x, 10		;Answer correct
	movzx ax, answerL
	add xyPosition.x, ax
	add xyPosition.x, 3
	movzx ax, bl
	mov xyPosition.y, ax
	INVOKE WriteConsoleOutputAttribute,
      outputHandle,
      ADDR attributes2,
      LENGTHOF Clear,
      xyPosition,
      ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
	  ADDR Clear,
	  LENGTHOF Clear,
	  xyPosition,
	  ADDR bytesWritten
	Add xyPosition.x, 24
	INVOKE SetConsoleCursorPosition, outputHandle, xyPosition
	mov eax, 1500
	call Delay
	ret
ENDE:
	pop edi
	pop esi
	pop edx
	pop ebx
	mov xyPosition.x, 10
	movzx ax, answerL
	add xyPosition.x, ax
	add xyPosition.x, 3
	movzx ax, bl
	mov xyPosition.y, ax
	INVOKE WriteConsoleOutputAttribute,
      outputHandle,
      ADDR attributes3,
      LENGTHOF TryAgain,
      xyPosition,
      ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
	  ADDR TryAgain,
	  LENGTHOF TryAgain,
	  xyPosition,
	  ADDR bytesWritten
	inc bl
	jmp Ans
	
EasyLevel ENDP

MediumLevel PROC
	
	mov eax, 6+15*16
	CALL SetTextColor
	Call ClrScr
	mov xyPosition.x, 10
	mov xyPosition.y, 5
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR Gline00,
      LENGTHOF Gline00,
      xyPosition,
      ADDR bytesWritten
	add xyPosition.y, 2
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR ienter00,
      LENGTHOF ienter00,
      xyPosition,
      ADDR bytesWritten
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR ienter01,
      LENGTHOF ienter01,
      xyPosition,
      ADDR bytesWritten
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR ienter02,
      LENGTHOF ienter02,
      xyPosition,
      ADDR bytesWritten
	add xyPosition.y, 2
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR Gline01,
      LENGTHOF Gline01,
      xyPosition,
      ADDR bytesWritten

	mov dh, 12
	mov dl, 10
	Call Gotoxy
	movzx ecx, ienter03L ;the length of the word provide by A
	mov ax, 0C5Fh
PD:	Call WriteChar		 ;print '_'
	loop PD
	mov bl, 13
Ans:mov dh, bl			 ;enter answer
	mov dl, 10
	Call Gotoxy
	mov edx, OFFSET answer
	movzx ecx, ienter03L+1
	Call ReadString
	mov answerL, al		  ;answer LENGTH
	movzx ecx, ienter03L  ;compare answer
	push ebx
	push edx
	push esi
	push edi
	mov esi, BYTE PTR OFFSET ienter03
	mov edi, BYTE PTR OFFSET answer
Check:
	mov bl, [esi]
	mov dl, [edi]
	cmp bl, dl
	je equal
	jmp ENDE
equal:
	cmp al, ienter03L		 ;check for over entered
	jne ENDE 
	inc esi
	inc edi
	loop Check
	pop edi
	pop esi
	pop edx
	pop ebx
	mov xyPosition.x, 10		;Answer correct
	movzx ax, answerL
	add xyPosition.x, ax
	add xyPosition.x, 3
	movzx ax, bl
	mov xyPosition.y, ax
	INVOKE WriteConsoleOutputAttribute,
      outputHandle,
      ADDR attributes2,
      LENGTHOF Clear,
      xyPosition,
      ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
	  ADDR Clear,
	  LENGTHOF Clear,
	  xyPosition,
	  ADDR bytesWritten
	Add xyPosition.x, 24
	INVOKE SetConsoleCursorPosition, outputHandle, xyPosition
	mov eax, 1500
	call Delay
	ret
ENDE:					;Answer wrong
	pop edi
	pop esi
	pop edx
	pop ebx
	mov xyPosition.x, 10
	movzx ax, answerL
	add xyPosition.x, ax
	add xyPosition.x, 3
	movzx ax, bl
	mov xyPosition.y, ax
	INVOKE WriteConsoleOutputAttribute,
      outputHandle,
      ADDR attributes3,
      LENGTHOF TryAgain,
      xyPosition,
      ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
	  ADDR TryAgain,
	  LENGTHOF TryAgain,
	  xyPosition,
	  ADDR bytesWritten
	inc bl
	jmp Ans
MediumLevel ENDP

HardLevel PROC
	
	mov eax, 4+15*16
	CALL SetTextColor
	Call ClrScr
	mov xyPosition.x, 10
	mov xyPosition.y, 5
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR Gline00,
      LENGTHOF Gline00,
      xyPosition,
      ADDR bytesWritten
	add xyPosition.y, 2
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR ienter00,
      LENGTHOF ienter00,
      xyPosition,
      ADDR bytesWritten
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR ienter01,
      LENGTHOF ienter01,
      xyPosition,
      ADDR bytesWritten
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR ienter02,
      LENGTHOF ienter02,
      xyPosition,
      ADDR bytesWritten
	add xyPosition.y, 2
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR think,
      LENGTHOF think,
      xyPosition,
      ADDR bytesWritten
	mov dh,11
	mov dl,44
	Call Gotoxy
	
	INVOKE Sleep, 10000
	Call ClrScr
	mov eax, 0+15*16
	CALL SetTextColor
	mov xyPosition.y, 12	;Answer
	mov xyPosition.x, 10
	INVOKE WriteConsoleOutputCharacter,
      outputHandle,
      ADDR Gline01,
      LENGTHOF Gline01,
      xyPosition,
      ADDR bytesWritten
	mov dh, 13
	mov dl, 10
	Call Gotoxy
	movzx ecx, ienter03L ;the length of the word provide by A
	mov ax, 0C5Fh
PD:	Call WriteChar		 ;print '_'
	loop PD
	mov bl, 14
Ans:mov dh, bl			 ;enter answer
	mov dl, 10
	Call Gotoxy
	mov edx, OFFSET answer
	movzx ecx, ienter03L+1
	Call ReadString
	mov answerL, al		  ;answer LENGTH
	movzx ecx, ienter03L  ;compare answer
	push ebx
	push edx
	push esi
	push edi
	mov esi, BYTE PTR OFFSET ienter03
	mov edi, BYTE PTR OFFSET answer
Check:
	mov bl, [esi]
	mov dl, [edi]
	cmp bl, dl
	je equal
	jmp ENDE
equal:
	cmp al, ienter03L		 ;check for over entered
	jne ENDE 
	inc esi
	inc edi
	loop Check
	pop edi
	pop esi
	pop edx
	pop ebx
	mov xyPosition.x, 10		;Answer correct
	movzx ax, answerL
	add xyPosition.x, ax
	add xyPosition.x, 3
	movzx ax, bl
	mov xyPosition.y, ax
	INVOKE WriteConsoleOutputAttribute,
      outputHandle,
      ADDR attributes2,
      LENGTHOF Clear,
      xyPosition,
      ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
	  ADDR Clear,
	  LENGTHOF Clear,
	  xyPosition,
	  ADDR bytesWritten
	Add xyPosition.x, 24
	INVOKE SetConsoleCursorPosition, outputHandle, xyPosition
	mov eax, 1500
	call Delay
	ret
ENDE:
	pop edi
	pop esi
	pop edx
	pop ebx
	mov xyPosition.x, 10
	movzx ax, answerL
	add xyPosition.x, ax
	add xyPosition.x, 3
	movzx ax, bl
	mov xyPosition.y, ax
	INVOKE WriteConsoleOutputAttribute,
      outputHandle,
      ADDR attributes3,
      LENGTHOF TryAgain,
      xyPosition,
      ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
	  ADDR TryAgain,
	  LENGTHOF TryAgain,
	  xyPosition,
	  ADDR bytesWritten
	inc bl
	jmp Ans
HardLevel ENDP

main PROC
	call ClrScr
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov outputHandle , eax
	INVOKE GetStdHandle, STD_INPUT_HANDLE
	mov inputHandle , eax
	INVOKE InitialScreen
GAME:
	INVOKE Introduction
	INVOKE Scenes1
	mov eax, 7+0*16
	CALL SetTextColor
	Call ClrScr
	
	mov dl, 25
	mov dh, 8
	Call Gotoxy
	push edx
	mov edx, OFFSET PlayAgain
	mov ecx,3
D:  mov al, BYTE PTR [edx]		;Do
	Call WriteChar
	inc edx
	loop D
	mov eax, 500
	Call Delay
	mov ecx,4
Y:  mov al, BYTE PTR [edx]		;you
	Call WriteChar
	inc edx
	loop Y
	mov eax, 500
	Call Delay
	mov ecx,5
W:  mov al, BYTE PTR [edx]		;want
	Call WriteChar
	inc edx
	loop W
	mov eax, 500
	Call Delay
	mov ecx,3
T:  mov al, BYTE PTR [edx]		;to
	Call WriteChar
	inc edx
	loop T
	mov eax, 500
	Call Delay
	mov ecx,5
P:  mov al, BYTE PTR [edx]		;play
	Call WriteChar
	inc edx
	loop P
	mov eax, 1000
	Call Delay
	mov ecx,6
A:  mov al, BYTE PTR [edx]		;again
	Call WriteChar
	inc edx
	loop A
	mov eax, 1500
	Call Delay
	mov ecx,3
E:  mov al, BYTE PTR [edx]		; y
	Call WriteChar
	inc edx
	loop E
	mov eax, 1500
	Call Delay
	mov ecx,7
S:  mov al, BYTE PTR [edx]		; /others
	Call WriteChar
	inc edx
	loop S
	mov eax, 500
	Call Delay
	pop edx
	
	
	mov dl, 62
	mov dh, 8
	Call Gotoxy
	CALL ReadChar
	.IF ax == 1579h 		; enter to enter game
		jmp GAME
	.ENDIF
	mov eax, 0+15*16		;Game over thank
	CALL SetTextColor
	call ClrScr
	mov xyPosition.x, 45
	mov xyPosition.y, 12
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
	  ADDR Thank00,
	  LENGTHOF Thank00,
	  xyPosition,
	  ADDR bytesWritten
	  
	  
	mov dl, 41
	mov dh, 15
	Call Gotoxy
	mov ecx, LENGTHOF Thank01
	push edx
	mov edx, OFFSET Thank01  
Th1:mov al, BYTE PTR [edx]	  
	Call WriteChar
	mov eax, 150
	inc edx
	Call Delay
	loop Th1
	pop edx
	
	mov dl, 40
	mov dh, 16
	Call Gotoxy
	mov ecx, LENGTHOF Thank02
	push edx
	mov edx, OFFSET Thank02
Th2:mov al, BYTE PTR [edx]	  
	Call WriteChar
	mov eax, 150
	inc edx
	Call Delay
	loop Th2
	pop edx
	
	mov eax, 5000
	Call Delay
exit
main ENDP
END main