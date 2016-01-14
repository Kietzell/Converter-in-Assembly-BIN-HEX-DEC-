TITLE BinToHexDec
INCLUDE Irvine32.inc
.data
source BYTE "00000000",0
buffer BYTE "00000000",0
BufSize  = ($-buffer)-1

Part1 BYTE "00000000",0
Part2 BYTE "00000000",0

hexF BYTE "11110000",0
hexE BYTE "11100000",0
hexD BYTE "11010000",0
hexC BYTE "11000000",0
hexB BYTE "10110000",0
hexA BYTE "10100000",0
hex9 BYTE "10010000",0
hex8 BYTE "10000000",0
hex7 BYTE "01110000",0
hex6 BYTE "01100000",0
hex5 BYTE "01010000",0
hex4 BYTE "01000000",0
hex3 BYTE "00110000",0
hex2 BYTE "00100000",0
hex1 BYTE "00010000",0
hex0 BYTE "00000000",0

xF		BYTE "F",0
xE		BYTE "E",0
xD		BYTE "D",0
xC		BYTE "C",0
xB		BYTE "B",0
xA		BYTE "A",0

.code
main PROC
	mov edx, OFFSET buffer
	mov ecx,SIZEOF buffer	
	
	call ReadString			
	call DivideString
	XOR edx,edx
	call ReverseString

	INVOKE Str_copy, ADDR Part1, ADDR buffer
	call BinToHex
	mov ebx,0010h
	mul ebx
	mov edi,eax

	INVOKE Str_copy, ADDR Part2, ADDR buffer
	call BinToHex
	call Crlf
	add eax,edi
	call WriteDec
	call Crlf

	exit
main ENDP


DivideString PROC
	mov ecx,BufSize
	mov esi,0
D1:
	movzx eax,buffer[esi]
	push eax
	inc esi
	loop D1
	
	mov ecx,4
	mov esi,0

D2:
	pop eax
	mov Part2[esi],al
	inc esi
	loop D2

	mov ecx,4
	mov esi,0

D3:
	pop eax
	mov Part1[esi],al
	inc esi
	loop D3
	ret
DivideString ENDP


ReverseString PROC
	mov ecx,4
	mov esi,0
D21:
	movzx eax,Part1[esi]
	push eax
	inc esi
	loop D21
	
	mov ecx,4
	mov esi,0
D22:
	pop eax
	mov Part1[esi],al
	inc esi
	loop D22

	XOR eax,eax
	mov ecx,4
	mov esi,0

D31:
	movzx eax,Part2[esi]
	push eax
	inc esi
	loop D31
	
	mov ecx,4
	mov esi,0

D32:
	pop eax
	mov Part2[esi],al
	inc esi
	loop D32
	ret
ReverseString ENDP

BinToHex PROC
	INVOKE Str_compare, ADDR hexF, ADDR buffer
	Jne L2
L1:
	mov edx,OFFSET xF
	mov eax,000Fh
	call WriteString
	jmp quit

L2:
	INVOKE Str_compare, ADDR hexE, ADDR buffer
	Jne L3
	mov eax,000Eh
	mov edx,OFFSET xE
	call WriteString
	jmp quit

L3:
	INVOKE Str_compare, ADDR hexD, ADDR buffer
	Jne L4
	mov eax,000Dh
	mov edx,OFFSET xD
	call WriteString
	jmp quit
L4:
	INVOKE Str_compare, ADDR hexC, ADDR buffer
	Jne L5
	mov eax,000Ch
	mov edx,OFFSET xC
	call WriteString
	jmp quit
L5:
	INVOKE Str_compare, ADDR hexB, ADDR buffer
	Jne L6
	mov eax,000Bh
	mov edx,OFFSET xB
	call WriteString
	jmp quit
L6:
	INVOKE Str_compare, ADDR hexA, ADDR buffer
	Jne L7
	mov eax,000Ah
	mov edx,OFFSET xA
	call WriteString
	jmp quit
L7:
	INVOKE Str_compare, ADDR hex9, ADDR buffer
	Jne L8
	mov eax,9
	call WriteDec
	jmp quit
L8:
	INVOKE Str_compare, ADDR hex8, ADDR buffer
	Jne L9
	mov eax,8
	call WriteDec
	jmp quit
L9:
	INVOKE Str_compare, ADDR hex7, ADDR buffer
	Jne L10
	mov eax,7
	call WriteDec
	jmp quit
L10:
	INVOKE Str_compare, ADDR hex6, ADDR buffer
	Jne L11
	mov eax,6
	call WriteDec
	jmp quit
L11:
	INVOKE Str_compare, ADDR hex5, ADDR buffer
	Jne L12
	mov eax,5
	call WriteDec
	jmp quit
L12:
	INVOKE Str_compare, ADDR hex4, ADDR buffer
	Jne L13
	mov eax,4
	call WriteDec
	jmp quit
L13:
	INVOKE Str_compare, ADDR hex3, ADDR buffer
	Jne L14
	mov eax,3
	call WriteDec
	jmp quit
L14:
	INVOKE Str_compare, ADDR hex2, ADDR buffer
	Jne L15
	mov eax,2
	call WriteDec
	jmp quit
L15:
	INVOKE Str_compare, ADDR hex1, ADDR buffer
	Jne L16
	mov eax,1
	call WriteDec
	jmp quit
L16:
	INVOKE Str_compare, ADDR hex0, ADDR buffer
	mov eax,0
	call WriteDec

quit:
ret
BinToHex ENDP
END main