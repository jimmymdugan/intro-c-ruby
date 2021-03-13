/*
 * Implementation of the read_data module.
 *
 * See read_data.h for a description of the read_data function's
 * specification.
 *
 * Note that the parameter declarations in this module must be
 * compatible with those in the read_data.h header file.
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "read_data.h"

// Reads the three fields from lines such as W$1349$1.414$ into
// local variables using getchar().
// Converts the two numeric fields to numbers using atoi for the
// integer fields and atof for the double.
// Using a correctly defined set of parameters (use pointers) pass
// those values back to the program that called this function.
void read_data(char *carg, int *iarg, double *darg) {
	/* your declarations and statements REPLACE this comment */
	char c; //store character
	char store_integer[26];//25+1
	char store_decimal[26];//25+1
	double d;//value od dec
	int i;// value of int
	int j; //for read char val

	//char
	char tmp = getchar();
	while (tmp != '$') {
		c = tmp;
		tmp = getchar();
	}

	//int
        j = 0;
	tmp = getchar();
	while (tmp != '$') {
		store_integer[j++] = tmp;
		tmp = getchar();
	}
	store_integer[j] = '\0';
	i = atoi(store_integer);

	//dec
	j = 0;
	tmp = getchar();
	while (tmp != '$') {
		store_decimal[j++] = tmp;
		tmp = getchar();
	}
	store_decimal[j] = '\0';
	d = atof(store_decimal);
	//param vals w pointers
	*carg = c;
	*iarg = i;
	*darg = d;

	return ;
}
