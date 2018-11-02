#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double calcLength(int*, int);
void normVectorOutput(int*, int);

int main() {
	int numInput;
	scanf("%d", &numInput);
	int *vector_array = (int *) malloc(sizeof(int) * numInput);
	int i;
	for (i=0; i < numInput; i++) {
		scanf("%d",&vector_array[i]);		
	}
	normVectorOutput(vector_array, numInput);
	return EXIT_SUCCESS;
} 

double calcLength(int *array_pointer,int numInput) {
	int i;
	int sum = 0;
	for (i=0; i< numInput; i++) {
		sum = sum + pow(array_pointer[i],2);
	}
	return sqrt(sum);
}

void normVectorOutput(int *array_pointer,int numInput) {
	int i;
	double norm;
	for (i=0; i< numInput; i++) {
		norm = array_pointer[i]/calcLength(array_pointer,numInput);
		printf("%.3f ",norm);
	}
}