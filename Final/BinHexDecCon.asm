TITLE BinHexDecCon
INCLUDE Irvine32.inc

.data
message BYTE "===========================================================",0dh,0ah
	BYTE "Welcome to the BIN/DEC/HEX Converter",0dh,0ah
	BYTE "Choose number corresponding to the action you'd like to take",0dh,0ah
	BYTE "1.If you'd like to convert a DEC to BIN and HEX",0dh,0ah
	BYTE "2.If you'd like to convert a BIN to DEC and HEX",0dh,0ah
	BYTE "3.If you'd like to convert a HEX to DEC and BIN",0dh,0ah
	BYTE "4.If you'd like to quit the application",0dh,0ah
	BYTE "============THANK YOU======================================",0


DMsg BYTE "Please enter a decimal Number: ",0
BMsg BYTE "Please enter a 8-digit Binary Number :",0
HMsg BYTE "Please enter a Hexadecimal Number: ",0

DecMsg BYTE "DEC==>",0
BinMsg BYTE "BIN==>",0
HexMsg BYTE "HEX==>",0

invalid BYTE "your entry is invalid please start over again, Thanks",0
choice BYTE 1 DUP(0),0

one BYTE "1",0
two BYTE "2",0
three BYTE "3",0
four BYTE "4",0

decVal DWORD ?
hexVal DWORD ?

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
	mov edx,OFFSET message
	call WriteString
	call Crlf
	call Crlf
	call Menu
	call Crlf
	
	exit
main ENDP

Menu PROC
	mov edx,OFFSET choice
	mov ecx, SIZEOF choice
	call ReadString

	INVOKE Str_compare, ADDR one, ADDR choice
	Jne P2
P1:
	mov edx, OFFSET DMsg
	call WriteString
	call readDec
	mov decVal,eax
	mov ebx, TYPE WORD
	mov edx, OFFSET HexMsg
	call WriteString
	call WriteHexB
	call Crlf
	mov edx, OFFSET BinMsg
	call WriteString
	call WriteBinB
	call Crlf
	jmp quit

P2: 
	INVOKE Str_compare, ADDR two, ADDR choice
	Jne P3
	mov edx,OFFSET BMsg
	call WriteString
	XOR edx,edx
	mov edx,OFFSET buffer
	mov ecx,SIZEOF buffer
	call ReadString
	call DivideString
	XOR edx,edx
	call ReverseString
	
	INVOKE Str_copy, ADDR Part1, ADDR buffer
	mov edx,OFFSET HexMsg
	call WriteString
	call BinToHex
	mov ebx,0010h
	mul ebx
	mov edi,eax

	INVOKE Str_copy, ADDR Part2, ADDR buffer
	call BinToHex
	call Crlf
	add eax,edi
	mov edx,OFFSET DecMsg
	call WriteString
	call WriteDec
	call Crlf
	jmp quit


P3: 
	INVOKE Str_compare, ADDR three, ADDR choice
	Jne P4
	mov edx,OFFSET HMsg
	call WriteString
	call readHex
	mov hexVal,eax
	mov ebx,TYPE WORD
	mov edx,OFFSET DecMsg
	call WriteString
	call WriteDec
	call Crlf
	mov edx,OFFSET BinMsg
	call WriteString
	call WriteBinB
	call Crlf
	jmp quit


P4:
	INVOKE Str_compare, ADDR four, ADDR choice
	Jne P5
	jmp quit
P5:
	mov edx,OFFSET invalid
	call WriteString

quit:	
	ret
Menu ENDP


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

