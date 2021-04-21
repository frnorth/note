all: printf

obj = printf2.o  main_printf1.o

flags = -arch=compute_61 -rdc=true

printf2.o : printf2.cu
	nvcc ${flags} --device-c printf2.cu
main_printf1.o : main_printf1.cu
	nvcc ${flags} --device-c main_printf1.cu

printf : ${obj}
	nvcc ${flags} -o printf ${obj}

clean:
	${RM} ${obj} printf
