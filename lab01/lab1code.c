//Tania Pham
//January 15, 2020
//Lab1Code.c

#include <stdio.h>
#include <stdint.h>

//Converts the given array of bits to an UNSIGNED int.
uint32_t Bits2Unsigned(int8_t bits[8])
{
	int i;
	uint32_t j=0;
	for (i = 7; i >= 0; i--) 
	{
		j = ((2 * j) + bits[i]); //binary is in powers of 2
	}
	return j;
}

//Converts the given array of bits to a SIGNED int.
int32_t Bits2Signed(int8_t bits[8])
{
	int i; 
	int32_t j = 0;
	for (i = 6; i >= 0; i--) //followed pseudocode in lab1
	{
		j = ((2 * j) + bits[i]);
	}
	j -= bits[7]*128;
	return j;
}

//Increments the given array of bits.
void Increment(int8_t bits[8])
{
	int firstZero = 0; //keeps track of when we hit the first zero
	for (int i = 0; i < 8; i++) //start from the least significant bit
	{
		if(firstZero == 0) //flip everything up until the first zero including the first zero
		{
			if(bits[i] == 1)
				bits[i] = 0;
			else //bits[i]==0
			{
				bits[i]=1;
				firstZero = 1;
			}
		}
		else //copy everything else to the left of the first zero
		{
			if(bits[i]==0)
				bits[i]=0;
			else
				bits[i]=1;
		}
	}
	return;
}

//Converts the given n value (which is UNSIGNED) to an array of bits.
void Unsigned2Bits(uint32_t n, int8_t bits[8])
{
	int i;
	//store mod 2 of n from lowest array index to highest and divide by two each time
	for (i = 0; i < 8; i++)
	{
		bits[i] = n%2; 
		n /= 2;
	}
	return;
}