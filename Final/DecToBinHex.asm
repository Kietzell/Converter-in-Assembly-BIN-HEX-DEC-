TITLE DecToBinANDhex                 

INCLUDE Irvine32.inc

.data
decVal  DWORD ?	; sample decimal


.code
main PROC
	call	readDec
	mov	decVal,eax			; EAX = decimal
	mov ebx,TYPE WORD
	call    WriteHexB
	call    Crlf
	call    WriteBinB
	call    Crlf
	exit
main ENDP


END main