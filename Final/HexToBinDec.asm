TITLE HexToBinDec
INCLUDE Irvine32.inc

.data
hexVal	DWORD ?
.code
main PROC
	call readHex
	mov hexVal,eax
	mov ebx,TYPE WORD
	call WriteBin
	call Crlf
	call WriteDec
	call Crlf
main ENDP
END main