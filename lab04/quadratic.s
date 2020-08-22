//Tania Pham
//February 5, 2020
//quadratic.s


	.syntax		unified
	.cpu		cortex-m4
	.text
	
//int32_t Discriminant(int32_t a, int32_t b, int32_t c)
	.global		Discriminant
	.thumb_func
Discriminant:	MUL R1,R1,R1	//R1 = b*b
				LSL R0,R0,2		//R0 = 4*a
				MLS R0,R0,R2,R1	//R0 = b*b - 4*a*c
				BX LR

//int32_t Root1(int32_t a, int32_t b, int32_t c)
	.global		Root1
	.thumb_func
Root1:	PUSH {R4,R5,LR}		//preserve R4 and R5
		MOV R4,R0			//R4 = a
		NEG R5,R1			//R5 = -b
		BL Discriminant
		BL SquareRoot
		ADD R0,R5,R0		//R0 = SquareRoot(...)
		LSL R4,R4,1			//R0 = -b+SquareRoot(...)
		SDIV R0,R0,R4		//R4 = a*2
		POP {R4,R5,PC}		//restore R4 and R5

//int32_t Root2(int32_t a, int32_t b, int32_t c)
	.global		Root2
	.thumb_func
Root2:	PUSH {R4,R5,LR}
		MOV R4,R0
		MOV R5,R1
		NEG R5,R5
		BL Discriminant
		BL SquareRoot
		SUB R0,R5,R0	//same as Root1 except R0 = -b-SquareRoot(...)
		LSL R4,R4,1
		SDIV R0,R0,R4
		POP {R4,R5,PC}

//int32_t Quadratic(int32_t a, int32_t b, int32_t c)
	.global		Quadratic
	.thumb_func
Quadratic:	MLA R3,R2,R0,R3		//R3 = b*x + c
			MUL R0,R0,R0		//R0 = x^2
			MLA R0,R0,R1,R3		//R0 = (b*x + c) + a*x^2
			BX LR
			
	.end
	
	
