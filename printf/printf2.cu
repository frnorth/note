#include <stdio.h>

__global__ void Hello_World_2(int n) {

	int id = threadIdx.x;
	n--;
	printf("Hello World! 22222 %d %d\n", id, n);
	if(n > 0) {
		cudaStream_t s;
		cudaStreamCreateWithFlags(&s, cudaStreamNonBlocking);
		Hello_World_2<<< 1, 1 >>>(n); //, 0, s >>>(n);
		cudaStreamDestroy(s);
	}

}
