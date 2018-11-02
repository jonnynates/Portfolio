#include <stdio.h>
#include <stdlib.h>

void setupArray(char**);
int calcNeighbours(char**, int, int)

int rows, columns, numSimulate;

int main() {
	char** arrBoard;
	int numSimulate = setupArray(arrLife);
	int i;
	for (i = 0; i < numSimulate; i++) {
		
	}
	
	
	return EXIT_SUCCESS;
}

void setupArray(char** arrBoard) {
	int r,c;
	scanf("%d %d %d",&rows, &colums, &numSimulate);
	arrBoard = (char**) malloc(sizeof(char*) * rows);
	
	for (r= 0; r < rows; r++) {
		arrBoard[r] = malloc(sizeof(char*) * columns);
		scanf("%s",&arrLife[r]);
	}
	
}

void gameRules() {
	int numNeighbours = calcNeighbours();
	
	
}

int calcNeighbours(char** arrBoard,int r,int c) {
	int safeLeft, safeRight, safeUp, safeDown, numNeighbours; //variables used to check out of bounds
	safeLeft = 0; //initialised to 0 (false) showing that it is out of bounds until proved otherwise
	safeRight = 0;
	safeUp = 0;
	safeDown = 0;
	numNeighbours = 0;
	
	//checks to make sure it checks in the bound areas
	if ((r - 1) >= 0) safeUp = 1;
	if ((r + 1) < rows) safeDown = 1;
	if ((c - 1) >= 0) safeLeft = 1;
	if ((c + 1) < columns)) safeRight = 1;
	
	
	if (safeLeft == 1) {
			if (arrBoard[r][c - 1] == "X") numNeighbours++; //checks left
	}
	
	if (safeRight == 1) {
			if (arrBoard[r][c + 1] == "X") numNeighbours++; //checks right
	}
		
	if (safeUp == 1 ) { //checks the row above the selected cell
		if (safeLeft == 1) {
			if (arrBoard[r-1][c -1] == "X") numNeighbours++; //check up diagonal left
			if (arrBoard[r][c - 1] == "X") numNeighbours++; //checks left
		}
		
		if (arrBoard[r-1][c] == "X") numNeighbours++; //checks up
		
		if (safeRight == 1) {
			if (arrBoard[r-1][c + 1] == "X") numNeighbours++; //checks up diagonal right
			if (arrBoard[r][c + 1] == "X") numNeighbours++; //checks right
		}
	}
	
	if (safeDown == 1) { //checks the row bellow the selected cell
		if (safeLeft == 1) {
			if (arrBoard[r+1][c -1] == "X") numNeighbours++; //check down diagonal left
		}
		
		if (arrBoard[r+1][c] == "X") numNeighbours++; //checks down
		
		if (safeRight == 1) {
			if (arrBoard[r+1][c + 1] == "X") numNeighbours++; //checks down diagonal right
		}
	}
	
	return numNeighbours;
}