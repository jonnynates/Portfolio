/*
	Jonathan Nates
	u5jn
	201120893
	
	Result: Accepted
	RunID: 117129
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct{
	int month;
	int day;
	int year;
} Date;

//declaring the functions
int monthToInt(char*);
const char* intToMonth(int);
void getInput();
int sortCompareFunc (const void* , const void* );
void output();
int compSearchFunc(const void * , const void * );


//global variables
int numDates;
Date* arrDate; //an array of structures
Date findDate; //object of the struct that will hold the date to find

/*
	Main function used to call other functions
*/
int main() {
	getInput();
	qsort(arrDate,numDates,sizeof(Date),sortCompareFunc);
	output();
	return EXIT_SUCCESS;
}

/*
	This function is responsible for converting the month string
	into an integer representation
*/
int monthToInt(char* monthStr) {
	int monthInt =0;
	if (strcmp(monthStr,"January")==0) monthInt = 1;
	else if (strcmp(monthStr,"February")==0) monthInt = 2;
	else if (strcmp(monthStr,"March")==0) monthInt = 3;
	else if (strcmp(monthStr,"April")==0) monthInt = 4;
	else if (strcmp(monthStr,"May")==0) monthInt = 5;
	else if (strcmp(monthStr,"June")==0) monthInt = 6;
	else if (strcmp(monthStr,"July")==0) monthInt = 7;
	else if (strcmp(monthStr,"August")==0) monthInt = 8;
	else if (strcmp(monthStr,"September")==0) monthInt = 9;
	else if (strcmp(monthStr,"October")==0) monthInt = 10;
	else if (strcmp(monthStr,"November")==0) monthInt = 11;
	else if (strcmp(monthStr,"December")==0) monthInt = 12;
	
	return monthInt;
}

/*
	This function is responsible for converting the month 
	integer representation back into a string
*/
const char* intToMonth(int monthInt) {
	switch(monthInt) {
		case 1: return "January"; 
		case 2: return "February";
		case 3: return "March";
		case 4: return "April";
		case 5: return "May";
		case 6: return "June";
		case 7: return "July";
		case 8: return "August";
		case 9: return "September";
		case 10: return "October";
		case 11: return "November";
		case 12: return "December";
	}
}

/*
	Function responsible for recieving input
*/
void getInput () {
	scanf("%d",&numDates); //gets the total number of dates
	arrDate = malloc(numDates * sizeof(Date*)); //allocates enough memory for all the dates
	int i;
	char tempMonth[10]; 
	int intMonth;
	
	for (i = 0; i < numDates; i++) { //Loop that reads all the dates and stores them in the array of structures
		scanf("%s %d %d",tempMonth, &arrDate[i].day, &arrDate[i].year);
		intMonth = monthToInt(tempMonth); //converts the string month to int
		arrDate[i].month = intMonth;

	}
	
	//scans the user query into a find date structure
	scanf("%d %d %d",&findDate.day,&findDate.month, &findDate.year);
}

/*
	Compare function used to sort the dates from newest date to oldest date
*/
int sortCompareFunc (const void * a, const void * b) {
	Date* d1 = (Date*)a;
	Date* d2 = (Date*)b;
	int d1year, d2year;
	
	//makes sure the year is in the correct format for sorting
	if ((d1->year <= 99) && (d1->year >= 90)) { 
		d1year = 1900 + d1->year;
	}
	else if ((d1->year <= 12) && (d1->year >= 00)) {
		d1year = 2000 + d1->year;
	}
	
	//makes sure the year is in the correct format for sorting
	if ((d2->year <= 99) && (d2->year >= 90)) {
		d2year = 1900 + d2->year;
	}
	else if ((d2->year <= 12) && (d2->year >= 00)) {
		d2year = 2000 + d2->year;
	}
	
	int yearCompare = d1year - d2year;
	if (yearCompare == 0) { //if year are the same it then compares months
		if (d1->month > d2->month) { //if the first month is greater than second
			return -1;
		}
		else if (d1->month < d2->month) { //if the second month is greater than first
			return 1;
		}
		else if (d1->month == d2->month) { //if months are same it compares days
			if (d1->day > d2->day) { //if day 1 is greater than day 2
				return -1;
			}
			else if (d1->day < d2->day) { //if day 2 is greater than day 1
				return 1;
			}
			else if (d1->day == d2->day) { //if the days are the same
				return 0;
			}
		}
	}
	else if (yearCompare > 0) { //if the first year is great than second
		return -1;
	}
	else { //if the second year is greater than first
		return 1;
	}
	
}

/*
	Function responsible for output
*/
void output() {
	int i;
	char tempMonth[10];
	for (i = 0; i < numDates; i++) { //for loop responsible for printing all dates
		strcpy(tempMonth,intToMonth(arrDate[i].month));
		printf("%s %d %02d\n",tempMonth, arrDate[i].day, arrDate[i].year);
	}
	
	//uses bsearch to try locate the find date query 
	int* foundPointer = (int*) bsearch(&findDate,arrDate,numDates,sizeof(Date),compSearchFunc); 
	if (foundPointer != NULL) { //if a pointer is returned then the date was found
		printf("Yes\n");
	}
	else {
		printf("No\n");
	}
}

/*
	Compare functions used to find the queried date
*/
int compSearchFunc(const void * a, const void * b) {
	Date* d1 = (Date*)a;
	Date* d2 = (Date*)b;
	if ((d2->year == d1->year) && (d2->month == d1->month) && (d2->day == d1->day)) {
		return *(int*)d1;
	}
	
}