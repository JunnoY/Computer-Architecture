	B part3 ; part1 or part2 or part3

buffer	DEFS 100,0

s1	DEFB "one\0"
	ALIGN
s2	DEFB "two\0"
	ALIGN
s3	DEFB "three\0"
	ALIGN
s4	DEFB "four\0"
	ALIGN
s5	DEFB "five\0"
	ALIGN
s6	DEFB "six\0"
	ALIGN
s7	DEFB "seven\0"
	ALIGN
s8	DEFB "twentytwo\0"
	ALIGN
s9	DEFB "twenty\0"
	ALIGN

;************************** part 1 **************************
printstring
		LDRB R0, [R1], #1
		CMP  R0, #0
		SVCNE 0
		BNE printstring
		MOV  R0, #10	; given - output end-of-line R0 has already been signed by #10 which is to start a new line by this time, so the 0s wont be printed out
		SVC  0		; given
		MOV  PC, LR	; given
;************************** part 2 ***************************
strcat
		LDRB R0, [R1], #1
		CMP  R0, #0
		BNE  strcat
		SUB R1, R1, #1

strcpy
	    LDRB R3, [R2], #1 ;the bracket means looking for any address in R2
		STRB R3, [R1], #1 ;The character in R3 is storing in any address(using square bracket) pointed to R1 and we need to add 1 to store the next character in a different address in R1
		CMP  R3,  #0
		BNE  strcpy
		MOV  PC, LR

;************************** part 3 **************************
sorted	STR LR, return2	; given
loop	LDRB R4, [R2], #1
		LDRB R5, [R3], #1
		CMP  R4, #0
		BEQ  return
		CMP  R5, #0
		BEQ  return
		CMP  R4, R5
		BNE  return
		B    loop ;for the twentytwo/0= twentytwo/0 case, eventually when the character reaches 0, will go to return 
return	
		CMP	 R4, R5
		LDR  PC, return2 ; given
		return2 DEFW 0		; given
;*********************** the various parts ********************
part1	ADR R1, s1
	BL  printstring
	ADR R1, s2
	BL  printstring
	ADR R1, s3
	BL  printstring
	ADR R1, s4
	BL  printstring
	ADR R1, s5
	BL  printstring
	ADR R1, s6
	BL  printstring
	ADR R1, s7
	BL  printstring
	ADR R1, s8
	BL  printstring
	ADR R1, s9
	BL  printstring
	SVC 2

part2	ADR R2, s1
	ADR R1, buffer
	BL  strcpy
	ADR R1, buffer
	BL  printstring
	ADR R2, s2
	ADR R1, buffer
	BL  strcat
	ADR R1, buffer
	BL  printstring
	ADR R2, s3
	ADR R1, buffer
	BL  strcat
	ADR R1, buffer
	BL  printstring
	SVC 2

; used by part3
return4 DEFW 0,0
test2	STR LR, return4		; This mechanism will be improved later
	STR R3, return4+4	; Assembler will evaluate addition	
	MOV R0, R2
	SVC 3
	BL  sorted
	MOVLT R0, #'<'		; Three-way IF using conditions
	MOVEQ R0, #'='
	MOVGT R0, #'>'
	SVC 0
	LDR R0, return4+4
	SVC 3
	MOV R0, #10
	SVC 0
	LDR PC, return4

part3	ADR R2, s1
	ADR R3, s2
	BL  test2
	ADR R2, s2
	ADR R3, s3
	BL  test2
	ADR R2, s3
	ADR R3, s4
	BL  test2
	ADR R2, s4
	ADR R3, s5
	BL  test2
	ADR R2, s5
	ADR R3, s6
	BL  test2
	ADR R2, s6
	ADR R3, s7
	BL  test2
	ADR R2, s7
	ADR R3, s8
	BL  test2
	ADR R2, s8
	ADR R3, s9
	BL  test2
	ADR R2, s8
	ADR R3, s8
	BL  test2
	SVC 2
