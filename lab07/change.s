//Tania Pham
//February 26, 2020
//change.s

	.syntax		unified
	.cpu		cortex-m4
	.text
	
//void Bills(uint32_t dollars, BILLS *paper);
	.global		Bills
	.thumb_func
Bills:	//R0 = dollars, R1 = papers
		LDR R2,=214728365 //2^32/20
		UMULL R2,R3,R0,R2 //R3 = quotient
		STR R3,[R1] //store R3 in 20s
		LSL R12,R3,4
		ADD R2,R12,R3,LSL2 //R2 = 20R3
		SUB R2,R0,R2 //R2 = remainder
Value:	LDR R3,=429496730 //2^32 / 10
		UMULL R12,R3,R3,R2
		STR R3,[R1,4] //store R3 in 10s
		LSL R12,R3,3
		ADD R12,R12,R3,LSL1 //R12 = 10R3
		SUB R2,R2,R12 //R2 = remainder
		LDR R3,=858993460 //2^32 / 5
		UMULL R12,R3,R3,R2
		STR R3,[R1,8] //store R3 in 5s
		ADD R12,R3,R3,LSL2 //R12 = 5R3
		SUB R2,R2,R12
		STR R2,[R1,12] //store R2 in 1s
		BX LR
		

//void Coins(uint32_t cents, COINS *coins);
	.global		Coins
	.thumb_func
Coins:	//R0 = cents, R1 = coins
		LDR R2,=171798691 //R^32/25
		UMULL R2,R3,R0,R2 //R3 = quotient
		STR R3,[R1] //store R3 in  25s
		ADD R3,R3,R3,LSL2
		ADD R2,R3,R3,LSL2 //R2 = 25R3
		SUB R2,R0,R2 //R2 = remainder
		B Value
	.end