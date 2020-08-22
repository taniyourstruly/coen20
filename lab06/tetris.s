//Tania Pham
//February 19, 2020
//tetris.s

	.syntax		unified
	.cpu		cortex-m4
	.text
	
//BOOL GetBit(uint16_t *bits, uint32_t row, uint32_t col);
	.global		GetBit
	.thumb_func
	.set		BITBANDING,1	//Comment out if not using bit-banding
	.ifdef		BITBANDING
GetBit: //R0 = uint16_t *bits, R1 = uint32_t row, R2 = uint32_t col (with bit-banding)
		SUB R3,R0,0x20000000
		LSL R3,R3,5 //shift bits left by 5 bits (multiply by 32)
		LSL R1,R1,2 //row*4
		ADD R1,R1,R2 //index = (row*4) + col
		ADD R3,R3,R1,LSL2
		ADD R3,R3,0x22000000
		LDRH R0,[R3]
		BX LR
		.else
	
GetBit: //R0 = uint16_t *bits, R1 = uint32_t row, R2 = uint32_t col
		LDRH R0,[R0]
		ADD R1,R2,R1,LSL2 //index = (row*4) + col
		LDR R3,=1
		LSL R3,R3,R1 //shifts 1 into bit position
		AND R0,R0,R3 //R0 <- R0 & shifted R3
		LSR R0,R0,R1 //shifts bit right by row
		BX LR
		.endif
	
//void PutBit(BOOL Value, uint16_t *bits, uint32_t row, uint32_t col);
	.global		PutBit
	.thumb_func
	.ifdef		BITBANDING
PutBit: //R0 = BOOL value, R1 = *bits, R2 = row, R3 = col (with bit-banding)
		PUSH {R4}
		SUB R12,R1,0x20000000
		LSL R12,R12,5 //shift bits left by 5 bits
		LSL R2,R2,2 //row*4
		ADD R2,R2,R3 //index = (row*4) + col
		ADD R12,R12,R2,LSL2
		ADD R12,R12,0x22000000
		STRH R0,[R12]
		POP {R4}
		BX LR
		.else
	
PutBit: //R0 = BOOL value, R1 = *bits, R2 = row, R3 = col
		LDRH R12,[R1]
		ADD R2,R3,R2, LSL2 //index = R2 = (row*4)+col
		LDR R3,=1
		LSL R3,R3,R2 //shifts 1 into bit position
		LSL R0,R0,R2
		BIC R12,R12,R3 //overwrites 1 into R12
		ORR R12,R0,R12 //writes value of R0 into R12
		STRH R12,[R1] //stores result into R1
		BX LR
		.endif
	
	.end