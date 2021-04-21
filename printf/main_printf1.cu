#include <stdio.h>

__global__ void Hello_World() {

	int id = threadIdx.x;
	printf("Hello World! %d\n", id);

}

int main() {

	int n = 10;
	__global__ void Hello_World();
	__global__ void Hello_World_2(int n);

	Hello_World<<<1, 10>>>();
    cudaDeviceSynchronize();

	Hello_World_2<<<1, 1>>>(n);
    cudaDeviceSynchronize();

}
