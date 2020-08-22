//Tania Pham
//January 29, 2020
//copy.s

	.syntax		unified
	.cpu		cortex-m4
	.text
	
	.global		UseLDRB
	.thumb_func
//void UseLDRB(void *dst, void *src);
UseLDRB:	.rept 512 //need to repeat 512/1 = 512 times
			LDRB R2,[R1],1 //1 bytes, 8 bits
			STRB R2,[R0],1
			.endr
			BX LR

	.global		UseLDRH
	.thumb_func
//void UseLDRH(void *dst, void *src);
UseLDRH:	.rept 256 //need to repeat 512/2 = 256 times
			LDRH R2,[R1],2 //2 bytes, 16 bits
			STRH R2,[R0],2
			.endr
			BX LR

	.global		UseLDR
	.thumb_func
//void UseLDR(void *dst, void *src);
UseLDR:		.rept 128 //need to repeat 512/3 = 128 times
			LDR R2,[R1],4 //need 1 register for 4 bytes
			STR R2,[R0],4
			.endr
			BX LR

	.global		UseLDRD
	.thumb_func
//void UseLDRD(void *dst, void *src);
UseLDRD:	.rept 64 //need to repeat 512/8 = 64 times
			LDRD R3,R2,[R1],8 //need 2 registers for 8 bytes
			STRD R3,R2,[R0],8
			.endr
			BX LR

	.global		UseLDM
	.thumb_func
//void UseLDM(void *dst, void *src);
UseLDM:		PUSH {R4-R9}
			.rept 16 //need to repeat 512/32 = 16 times
			LDMIA R1!,{R2-R9} //need 8 registers for 32 bytes
			STMIA R0!,{R2-R9}
			.endr
			POP {R4-R9}
			BX LR

	.end