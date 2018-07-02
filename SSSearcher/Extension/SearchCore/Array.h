#ifndef Array_H
#define Array_H

/*
 ============================================================================
 Author: kewenya

	注意 Array使用，定义后需进行初始化ArrayInit，使用后需释放资源Reset
	例如:
	Array text;
	ArrayInit( &text );
	text.Reset( &text );
 ============================================================================
*/


#include <stdio.h>
#include <stdlib.h>

//最大空间为   MALLOC_SIZE*INDEX_NUM_MAX = 12800

#define MALLOC_NUM  8   //2进制  个数为1<<MALLOC_NUM
#define MALLOC_SIZE 256 // = 1<<MALLOC_NUM
#define INDEX_NUM_MAX  50



#define MallocIndexByte (INDEX_NUM_MAX*sizeof(NSInteger))
#define MallocByte (MALLOC_SIZE*sizeof(NSInteger))

typedef struct ArrayData
{
	NSInteger* pData;
	struct ArrayData* next;
}ArrayData;

typedef struct Array
{	
	NSInteger size;
	NSInteger mallocsize;       //数据域个数

	NSInteger** pIndexData;	  //索引空间首地址
	NSInteger pIndexNum;        //索引空间个数

	NSInteger* pDataEnd;

	void (*Append)(struct Array* A,NSInteger value);
	void (*Insert)(struct Array* A,NSInteger value,NSInteger pos);
	void (*Remove)(struct Array* A,NSInteger index);
	void (*Reset)(struct Array* A);
	NSInteger (*GetValue)(struct Array* A,NSInteger index);

}Array;

void ArrayInit(struct Array* A);
void ArrayAppend(Array* A,NSInteger value);
void ArrayInsert(Array* A,NSInteger value,NSInteger pos);
void ArrayRemove(Array* A,NSInteger index);
void ArrayReset(Array* A);
NSInteger ArrayReSize(Array* A);
NSInteger ArrayGetValue(Array* A,NSInteger index);


typedef struct ArrayC
{	
	NSInteger  size;
	NSInteger  pDataSize;       //数据域个数
	NSInteger *pData;         //空间首地址
	
	NSInteger* pDataEnd;

	void (*Append)(struct ArrayC* A,NSInteger value);
	void (*Reset)(struct ArrayC* A);
	void (*SetSize)(struct ArrayC* A,NSInteger size);
	NSInteger (*GetValue)(struct ArrayC* A,NSInteger index);

}ArrayC;


void ArrayCInit(struct ArrayC* A);
void ArrayCAppend(ArrayC* A,NSInteger value);
void ArrayCReset(ArrayC* A);
NSInteger  ArrayCGetValue(ArrayC* A,NSInteger index);
void ArrayCSetSize(struct ArrayC* A,NSInteger size);

#endif
