#include "Array.h"

NSInteger sizeof_int = sizeof(NSInteger);

void ArrayInit(struct Array* A)
{
	A->size = 0;
	A->mallocsize = 0;

	A->pIndexData = 0;
	A->pIndexNum = 0;

	A->pDataEnd = 0;

	A->Append = &ArrayAppend;
	A->Insert =	&ArrayInsert;
	A->Remove = &ArrayRemove;
	A->Reset = &ArrayReset;
	A->GetValue = &ArrayGetValue;
	return;
}

void ArrayAppend(Array* A,NSInteger value)
{
	if( A->size < A->mallocsize || ArrayReSize( A ) > 0 )
	{
		*A->pDataEnd = value;
		A->size ++;

		if( A->size < A->mallocsize )
			A->pDataEnd ++;
	}

	return;
}
void ArrayInsert(Array* A,NSInteger value,NSInteger pos)
{
	NSInteger size = A->size;
	NSInteger i = 0;
	NSInteger* ptr = 0;
	NSInteger* ptr0 = 0;
	NSInteger** ptr_index = 0;

	if(pos >= 0 && pos <= size)
	{
		if( size < A->mallocsize || ArrayReSize(A) )	
		{
			ptr = A->pDataEnd;
			i = size;
			ptr_index = A->pIndexData + (A->size >> MALLOC_NUM);
			while(i > pos)
			{
				if( ptr == *ptr_index )
				{
					ptr_index --;
					ptr0 = *ptr_index;
					ptr0 = ptr0 + MALLOC_SIZE - 1;
				}
				else
				{
					ptr0 = ptr - 1;
				}

				*ptr = *ptr0;
				ptr = ptr0;
				i --;
			}

			*ptr = value;
			size ++;
			A->size = size;

			if( size < A->mallocsize )
				A->pDataEnd ++;
		}
	}

	return;
}
void ArrayRemove(Array* A,NSInteger index)
{
	NSInteger size = A->size;
	NSInteger i;
	NSInteger* ptr0 = 0;
	NSInteger* ptr = 0;
	NSInteger* ptr_temp = 0;
	NSInteger** ptr_index = 0;
	NSInteger pIndex = 0;
	
	if(index >= 0 && index < size)
	{	
		i = index;

		pIndex = index >> MALLOC_NUM;
		ptr_index = A->pIndexData + pIndex;
		index = index & (MALLOC_SIZE - 1);
		ptr_temp = *ptr_index;
		ptr0 = ptr = ptr_temp + index;
		size --;
	
		while(i < size)
		{
			index ++;
			if( index >= MALLOC_SIZE )
			{
				ptr_index ++;
				ptr = *ptr_index;
				index = 0;
			}
			else
			{
				ptr = ptr0 + 1;
			}
			*ptr0 = *ptr;
			ptr0 = ptr;
			i ++;
		} 

		A->size = size;
		A->pDataEnd = ptr;
	}

	return;
}
void ArrayReset(Array* A)
{
	NSInteger i = 0;
	
	for(i = 0;i < A->pIndexNum;i ++)
		free(*(A->pIndexData+i));	

	if( A->pIndexData )
		free(A->pIndexData);
	
	
	ArrayInit(A);
}

NSInteger ArrayReSize(Array* A)
{
	NSInteger	newsize;
	NSInteger* desData;
	NSInteger mallocsize = MallocByte;
	NSInteger mallocindexsize = MallocIndexByte;

	//内存不够
	if(A->pIndexNum + 1 >= INDEX_NUM_MAX )
		return 0;

	if( !A->pIndexData )
		A->pIndexData = (NSInteger**)malloc(mallocindexsize);
	
	newsize = A->mallocsize + MALLOC_SIZE;
	desData = (NSInteger*)malloc(mallocsize);

	*(A->pIndexData+A->pIndexNum) = desData;
	A->pIndexNum ++;

	A->pDataEnd = desData;
	A->mallocsize = newsize;

	return 1;
}

NSInteger ArrayGetValue(Array* A,NSInteger index)
{
	NSInteger* ptr = 0;
	NSInteger* ptr_index = 0;
	NSInteger pIndex = 0;

	if(index >= 0 && index < A->size)
	{
		pIndex = index >> MALLOC_NUM;
		ptr_index = *(A->pIndexData + pIndex);
		index = index & (MALLOC_SIZE - 1);
		ptr = ptr_index + index;

		return *ptr;
	}
	return -1;
}

void ArrayCInit(struct ArrayC* A)
{
	A->pData = 0;
	A->size = 0;
	A->pDataSize = 0;
	A->pDataEnd = 0;
	
	A->Append = &ArrayCAppend;
	A->Reset = &ArrayCReset;
	A->GetValue = &ArrayCGetValue;
	A->SetSize = &ArrayCSetSize;
	return;
}
void ArrayCAppend(ArrayC* A,NSInteger value)
{
	if( A->size < A->pDataSize )
		{
		*A->pDataEnd = value;
		A->size ++;

		if( A->size < A->pDataSize )
			A->pDataEnd ++;
		}
	return;
}
void ArrayCReset(ArrayC* A)
{
	if( A->pData )
	{
		free(A->pData);
	}

	ArrayCInit(A);
}
NSInteger  ArrayCGetValue(ArrayC* A,NSInteger index)
{
	if( index >= 0 && index < A->size )
		return *(A->pData + index);
	
	return -1;
}

void ArrayCSetSize(struct ArrayC* A,NSInteger size)
{
    if( A->pDataSize > 0 )
    	return;
    
    A->pDataSize = size;
    A->pData = (NSInteger*)malloc(size*sizeof_int);
	A->pDataEnd = A->pData;
}
