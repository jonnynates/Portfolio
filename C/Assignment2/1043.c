#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void sortArray(char**, int);
void output(char**,int);

int main() {
	char temp[100];
	int i,n,m, numElem;
	
	char** array_string;
	
	scanf("%d",&n);
	array_string = (char**) malloc(sizeof(char*) * n); //allocating memory for the number of rows
	for (i=0; i< n; i++) {
		scanf("%s",&temp);
		array_string[i] = malloc(sizeof(char) * strlen(temp) + 1); //allocating the memory for number of characters
		strcpy(array_string[i],temp);
	}
	
	scanf("%d",&m);
	numElem = n+m;
	array_string = (char**) realloc(array_string,numElem * sizeof(char*)); //allocating memory for the number of rows
	for (i=n; i< numElem; i++) {
		scanf("%s",&temp);
		array_string[i] = malloc(sizeof(char) * strlen(temp) +1); //allocating the memory for number of characters
		strcpy(array_string[i],temp);
	}
	
	sortArray(array_string, numElem);
	output(array_string,numElem);
	return EXIT_SUCCESS;
}

void sortArray(char** array, int numElem) {
	int i,j;
	char* temp;
	for (i= 0; i < (numElem -1); i++) {
		for (j= 0; j < (numElem - 1); j++) {
			if (strlen(array[j]) < strlen(array[j+1])) {
				temp = array[j];
				array[j] = array[j+1];
				array[j+1] = temp;
			}
		}
	}
}


void output(char** array, int numElem) {
	int i;
	for (i =0; i < numElem; i++) {
		printf("%s\n", array[i]);
	}
}