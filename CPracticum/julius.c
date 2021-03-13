#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#include "julius.h"


/* readline:
 *	Read a line of limited size lim into s,
 *	Return 0 if EOF was encountered, 1 otherwise.
 *	Terminate with a null character. Discard the newline character.
 */
int readline( char s[], int lim ){

	int i;
	char c;
	for (i = 0; i < lim; i++) {
		c = getchar();
		if (c == '\n') {
			break; //don't store to string
		} else if (c == EOF) {
			return 0; 
		}
		s[i] = c;
	}
	s[i] = '\0';
	return 1;


}
 

/*
 * julius:
 *	Perform the rotation encipher on the characters in the string
 * 	passed in as a character array by calling encipher on each character in  *   the string
 */
void julius(char string[]) {

	// ADD YOUR CODE HERE
	// Loop through the array, calling encipher(char), until the end of string.
	int i = 0;

	for(i; i<strlen(string); i++){
		string[i]=encipher(string[i]);
	}
}




/*
 * encipher:
 *	given a character of ASCII code 33 to 79, translate to 80 to 126 and
 *	vice versa.
 * *
*/
char encipher(char c){
	
	char value = c;
	if(value >=33 && value <=79)
		c+=47;
	if(value >=80 && value <=126)
		c-=47;



}
