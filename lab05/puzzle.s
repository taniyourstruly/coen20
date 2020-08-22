//Tania Pham
//February 12, 2020
//puzzle.s

	.syntax		unified
	.cpu		cortex-m4
	.text
	
//void CopyCell(RGB_PXL *dst, RGB_PXL *src);
	.global		CopyCell
	.thumb_func
CopyCell:	//RO = dst, R1 = src
			LDR R2,=0 //row = 0
outerLoop:	CMP R2,60 //row < 60?
			BHS Done
			LDR R3,=0 //col = 0
innerLoop: 	CMP R3,60
			BHS innerDone //col < 60?
			LDR R12,[R1,R3,LSL 2] //R12 = src[col]
			STR R12,[R0,R3,LSL 2] //R12->dst[col]
			ADD R3,R3,1 //col++
			B innerLoop
innerDone:	ADD R2,R2,1	//row++
			ADD R0,R0,960 //240*4
			ADD R1,R1,960
			B outerLoop
Done:		BX LR

			
//void FillCell(RGB_PXL *dst, uint32_t pixel);
	.global		FillCell
	.thumb_func

FillCell:	//RO = dst, R1 = pixel
			LDR R2,=0 //row = 0
outerL:		CMP R2,60 //row < 60?
			BHS D
			LDR R3,=0 //col = 0
innerL: 	CMP R3,60
			BHS innerD //col < 60?
			STR R1,[R0,R3,LSL 2] //R1->dst[col]
			ADD R3,R3,1 //col++
			B innerL
innerD:		ADD R2,R2,1 //row++
			ADD R0,R0,960 //dst+=240
			B outerL
D:			BX LR
						
	.end
						