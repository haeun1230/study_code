#include <stdlib.h>
#include <time.h> 
void nowtime()
{
	srand(time(NULL));
}
int randomnum()
{
	int a;
	
	a = rand()%45 +1; 
	
	return a;
}

//시간 함수, 랜덤함수를 사용 -> return a로 랜덤값을 반환함.