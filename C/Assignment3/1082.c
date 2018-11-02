/*
	Jonathan Nates
	u5jn
	201120893
	
	Result: Accepted
	RunID: 117167
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//Declaring functions
int* getInput(void);
void oddOrEvenSort(int*, int);
void sortLogic(int*,int*, int);
void output(int*);

//Function used the sort the numbers in ascending order
int cmpfunc(const void * a, const void * b) {
	return (*(int*)a - *(int*)b);
}

//Declaring global variables
int listLeng;
int sortLeng = 0;

/*
	Main function used to call other functions and has simple input
*/
int main() {
	int* arrNumbers;
	char oddOrEven[4];
	int isEven;
	
	scanf("%s",oddOrEven); //recieves a string input of 'odd' or 'even'
	if (strcmp(oddOrEven, "even")== 0) {
		isEven = 1;
	}
	else if (strcmp(oddOrEven, "odd")== 0) {
		isEven = 0;
	}
	
	arrNumbers = getInput();
	oddOrEvenSort(arrNumbers,isEven);
	output(arrNumbers);
	free(arrNumbers);
	return EXIT_SUCCESS;
}

/*
	Function used to get input
*/
int * getInput(void) {
	int i;
	scanf("%d",&listLeng); //scans the number of numbers in the list
	int * arrNumbers = (int*)malloc(sizeof(int) * listLeng); //allocates memory
	for (i = 0; i < listLeng; i++) { //scans the numbers into the array
		scanf("%d",&arrNumbers[i]);
	}
	return arrNumbers;
}

/*
	Function responsible for seperating the odd or even numbers from the array
	the sorting depends on the user input of 'odd' or 'even'
*/
void oddOrEvenSort(int* arrNumbers, int isEven) {
	int i;
	int* arrSort = (int*)malloc(sizeof(int) * listLeng);
	//if the user wants even numbers sorted
	if (isEven == 1) { 
		for (i = 0; i < listLeng; i++) {
			if (arrNumbers[i]%2 == 0) {
				arrSort[sortLeng] = arrNumbers[i];
				sortLeng++;
			}
		}
	}
	//if the user wants odd numbers sorted
	else if (isEven == 0) { 
		for (i = 0; i < listLeng; i++) {
			if (arrNumbers[i]%2 != 0) {
				arrSort[sortLeng] = arrNumbers[i];
				sortLeng++;
			}
		}
	}
	sortLogic(arrNumbers,arrSort,isEven);
	free(arrSort);
}

/*
	Function responsible for sorting the the seperated array and
	then transfering the sorted values back into the full aray
	without altering the pos of the unsorted values
*/
void sortLogic(int* arrNumbers,int* arrSort,int isEven) {
	qsort(arrSort, sortLeng, sizeof(int), cmpfunc);
	int sortPos = 0;
	int i;
	
	//if the user wants even numbers sorted
	if (isEven == 1) {
		for (i = 0; i < listLeng; i++) {
			if (arrNumbers[i]%2 == 0) {
				arrNumbers[i] = arrSort[sortPos];
				sortPos++;
			}
		}
	}
	
	//if the user wants odd numbers sorted
	else if (isEven == 0) {
		for (i = 0; i < listLeng; i++) {
			if (arrNumbers[i]%2 != 0) {
				arrNumbers[i] = arrSort[sortPos];
				sortPos++;
			}
		}
	}
}

/*
	Function responsible for output
*/
void output(int* arrNumbers) {
	int i;
	for (i = 0; i < listLeng; i++) {
		printf("%d ", arrNumbers[i]);
	}	
}