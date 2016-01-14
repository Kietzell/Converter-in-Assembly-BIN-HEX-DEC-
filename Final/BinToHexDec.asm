TITLE BinToHexDec
INCLUDE Irvine32.inc
.data
buffer	BYTE 5 DUP(0),0
letterF BYTE "1111",0
letterE BYTE "1110",0
F		BYTE "F",0
;E		BYTE "E",0
.code
main PROC
	mov edx, OFFSET buffer
	mov ecx,SIZEOF buffer
	call ReadString
	mov ecx,LENGTHOF buffer
	INVOKE Str_compare, ADDR letterF, ADDR buffer
	Jne L2
L1:
	mov edx,OFFSET F
	call WriteString
	call Crlf
	jmp quit
L2:
	INVOKE Str_compare, ADDR letterE, ADDR buffer
	mov eax,000Eh
	call WriteDec
	call WriteHexB
	call Crlf

quit: 
main ENDP
END main