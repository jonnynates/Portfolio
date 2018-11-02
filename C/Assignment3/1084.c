/*
	Jonathan Nates
	u5jn
	201120893
	
	Result: Accepted
	RunID: 117280
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//Declaring functions
void initialiseArray();
void movement();
void arrival(int);
void output();

//global variables
int** highwayGrid;

typedef struct {
	int timeStamp;
	int rowIndex;
} Schedule;

Schedule* arrSchedule;
int numRow, numCol, numTimesteps;
int numArrivals = 0;

/*
	Main function uses to call other functions and provide some logic
	for the timesteps
*/
int main() {
	initialiseArray();
	int i, j,arrivalPos;
	for (i=0; i < numTimesteps; i++) {
		movement();
		
		for(j=0; j<numArrivals; j++){
			if (arrSchedule[j].timeStamp == i) {
				arrival(arrSchedule[j].rowIndex);
			}
		}
		
			
	}
	output();
	//free(arrSchedule);
	//free(highwayGrid);
	return EXIT_SUCCESS;
}

/*
	Function used to initialise the array
*/
void initialiseArray() {
	scanf("%d %d %d",&numRow, &numCol, &numTimesteps);
	highwayGrid = (int**) malloc(sizeof(int*) * numRow);
	int r,c;
	for (r=0; r < numRow; r++){
		highwayGrid[r] = (int*) malloc(sizeof(int) * numCol);
		for (c=0; c < numCol; c++){
			highwayGrid[r][c] = 0;
		}
	}
	
	int tempTimeStamp, tempRowIndex;
	
	//allocates memory for the array of schedule then gets input for it
	arrSchedule = malloc(sizeof(Schedule));
	while (scanf("%d %d",&arrSchedule[numArrivals].timeStamp,&arrSchedule[numArrivals].rowIndex) != EOF) {
		numArrivals++;
		//arrSchedule = realloc(arrSchedule,numArrivals *  sizeof(Schedule));
		
		
	}
	
}

/*
	Function responsible for moving the vehicles
*/
void movement() {
	int r,c;
	for (c= (numCol-1); c >= 0; c--){ 
		for (r=0; r < numRow; r++){
			if (highwayGrid[r][c]==1) { //removes cars from the grid
				highwayGrid[r][c] = 0;
				if ((c+1) < numCol) { //if they are not out of bounds add them back one column right
					highwayGrid[r][c+1] = 1; 
				}
			}
		}
	}
	
}

/*
	Function responsible for adding new vehicles
*/
void arrival(int rowIndex) {
	highwayGrid[rowIndex][0] = 1;
}

/*
	Function responsible for output
*/
void output() {
	int r,c;
	for (r=0; r < numRow; r++) {
		for (c=0; c<numCol; c++){
			if (highwayGrid[r][c] == 0) {
				printf(".");
			}
			else printf("%d",highwayGrid[r][c]);
		}
		printf("\n");
	}
}