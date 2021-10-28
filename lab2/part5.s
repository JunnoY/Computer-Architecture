; Age History

	B  main

born DEFB "you were born in \0"
were DEFB "you were \0"
in	DEFB " in \0"
are	DEFB "you are \0"
this DEFB " this year\n\0"
	ALIGN

present DEFW 2021	; present = 2021 // Change this code
birth DEFW 2002	; birth = 2002   // Change this code
year DEFW 0	; year = 0      // Change this code
age DEFW 1	; age = 1        // Change this code


main
	; this code does print "you were born in " + str(birth) // DO NOT change the instructions below (except for part 5)
	ADR R0, born
	SVC 3
	LDR R0, birth ; make sure this will work!
	SVC 4
	MOV R0, #10
	SVC 0
	LDR R4, present
	LDR R5, birth
	LDR R6, year
	LDR R7, age
	ADD R6, R5, #1; year = birth + 1 // Change this code

start 
	CMP R6, R4
	BGE skip
		; while year != present //{ Change this code

	 ; this code does print "you were " + str(age) + " in " + str(year) // DO NOT change the instructions below (except for part 5)
	ADR R0, were
	SVC 3
	MOV R0, R7 ; make sure this will work!
	SVC 4
	ADR R0, in
	SVC 3
	MOV R0, R6 ; make sure this will work!
	SVC 4
	MOV R0, #10
	SVC 0
	ADD R6, R6,#1 ;year = year + 1 //Change this code
	ADD R7, R7,#1 ;age = age + 1   //Change this code
	; } //              //Change this code
	B start
skip

	; this code does print "you are " + str(age) + "this year" // DO NOT change the instructions below (except for part 5)
	ADR R0, are
	SVC 3
	MOV R0, R7 ; make sure this will work!
	SVC 4
	ADR R0, this
	SVC 3

	SVC 2 ; stop
