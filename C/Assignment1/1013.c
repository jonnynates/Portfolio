#include <stdio.h>
/* RunID : 91177 Result: Accepted */

/* Variables used for grouping the marks*/
int greatThan = 0;
int middle = 0;
int lessThan = 0;

/* Declaring the functions*/
void compare(int mark);
void output();

int main() {
	int end = 0;
	int temp = 0;
	
	while (end != 1) {
		scanf("%d",&temp);
		if (temp == 0) {
			end = 1;
		}
		else {
			compare(temp);
		}
	}
	output();
}

/* Function responsible for comparing and grouping the marks */
void compare(int mark) {
	if (mark >=85) {
		greatThan++;
	}
	else if ((mark < 85) && (mark >= 60)) {
		middle++;
	}
	else if (mark < 60) {
		lessThan++;
	}
}

/* Responsible for formating the output*/
void output() {
	printf(">=85:%d\n", greatThan);
	printf("60-84:%d\n", middle);
	printf("<60:%d\n", lessThan);
}