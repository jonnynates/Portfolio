#include <stdio.h>
#defnie ARRAY_SIZE = 256

char arrInput[ARRAY_SIZE];

void getInput();

int main() {
	getInput();
	printf("%c\n",arrInput[0]);
}

void getInput() {
	counter = 0;
	while(scanf("%c",temp) != EOF) {
		arrInput[counter] = temp;
		counter++;
	}
}