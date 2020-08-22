//January 22, 2020
//functions.s
//Tania Pham

		.syntax		unified
		.cpu		cortex-m4
		.text
	
	//	int32_t Add(int32_t a, int32_t b);
		.global		Add
		.thumb_func
	Add:	ADD R0,R0,R1	//adds a and b
			BX LR
			
	//	int32_t Less1(int32_t a);
		.global		Less1
		.thumb_func
	Less1:	SUB R0,R0,1		//subtracts a-1
			BX LR
	
	//	int32_t Square2x(int32_t x)
		.global		Square2x
		.thumb_func
	Square2x:	PUSH {LR}		
				ADD R0,R0,R0	//adds x and x
				BL Square		//R0 <-- Square(x+x)
				POP {PC}
				
	//	int32_t Last(int32_t x)
		.global		Last
		.thumb_func
	Last:	PUSH {R4,LR}	//preserves R4
			MOV R4,R0		//keep x safe in R4
			BL SquareRoot
			ADD R0,R0,R4	//adds x and SquareRoot(x)
			POP {R4,PC}		//restore R4
			
		.end
			
			
			