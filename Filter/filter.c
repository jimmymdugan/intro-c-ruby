/*
 * Implementation of functions that filter values in strings.
 *****
 * YOU MAY NOT USE ANY FUNCTIONS FROM <string.h> OTHER THAN
 * strcpy() and strlen()
 *****
 */

#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include "filter.h"

#define NUL ('\0')

/*
 * YOU MAY FIND THIS FUNCTION USEFUL.
 * Return true if and only if character <c> is in string <s>.
 */
static bool includes(char c, char *s) {
	while( *s && c != *s ) {
		s++ ;
	}
	return c == *s ;
}

/*
 * YOU MAY ALSO FIND THIS FUNCTION USEFUL.
 * Return true if and only if string <pre> is a prefix of string <s>.
 */
static bool prefix(char *s, char *pre) {
	while( *pre && *s == *pre ) {
		s++ ;
		pre++ ;
	}
	return *pre == NUL ;
}

/*
 * Copy <string> to <result> while removing all occurrences of <ch>.
 */
void filter_ch_index(char string[], char result[], char ch) {
	int string_i; 
	int result_i = 0; 

	for (string_i = 0; string_i < strlen(string); string_i++) {
		if (string[string_i] != ch) {
			result[result_i++] = string[string_i];
		}
	}
	result[result_i] = '\0'; 
}

/*
 * Return a pointer to a string that is a copy of <string> with
 * all occurrences of <ch> removed. The returned string must occupy
 * the least possible dynamically allocated space.
 *****
 * YOU MAY *NOT* USE INTEGERS OR ARRAY INDEXING.
 *****
 */
char *filter_ch_ptr(char *string, char ch) {
	char *p_copy = malloc(strlen(string) + 1); 
	char *p = p_copy; 
	while (*string != '\0') {
		if (*string != ch) {
			*p = *string;
			p++; 
		}
		string++; 
	}
	*p = '\0'; 

	p = malloc(strlen(p_copy) + 1); 
	strcpy(p, p_copy); 
	free(p_copy); 

	return p;
}
/*
 * Copy <string> to <result> while removing all occurrences of
 * any characters in <remove>.
 */
void filter_any_index(char string[], char result[], char remove[]) {
	int string_i; 
	int result_i = 0; 
	int remove_i; 
	for (string_i = 0; string_i < strlen(string); string_i++) {
		for (remove_i = 0; remove_i < strlen(remove); remove_i++) {
			if (string[string_i] == remove[remove_i]) {
				break;
			}
		}
		if (remove_i == strlen(remove)) { 
			result[result_i++] = string[string_i]; 
		}
	}
	result[result_i] = '\0'; 
}
/*
 * Return a pointer to a copy of <string> after removing all
 * occurrrences of any characters in <remove>.
 * The returned string must occupy the least possible dynamically
 * allocated space.
 *****
 * YOU MAY *NOT* USE INTEGERS OR ARRAY INDEXING.
 *****
 */
char *filter_any_ptr(char *string, char* remove) {
	char *p_copy = malloc(strlen(string) + 1); 
	char *p = p_copy; 
	char *remove_t; 
        while (*string != '\0') {
		remove_t = remove;
	
		while (*remove_t != '\0') {
			if (*string == *remove_t) {
				break; 
			}
			remove_t++;
		}
		if (*remove_t == '\0') { 
			*p = *string;
			p++;
		}
		string++;
        }
        *p = '\0'; //append null terminator

        p = malloc(strlen(p_copy) + 1); 
        strcpy(p, p_copy); 
        free(p_copy); 

        return p;
}
/*
 * Return a pointer to a copy of <string> after removing all
 * occurrrences of the substring <substr>.
 * The returned string must occupy the least possible dynamically
 * allocated space.
 *****
 * YOU MAY *NOT* USE ARRAY INDEXING.
 *****
 */
char *filter_substr(char *string, char* substr) {
        char *p_copy = malloc(strlen(string) + 1); 
        char *p = p_copy; 

        while (*string != '\0') {
		if (prefix(string, substr)) { 
			string += strlen(substr); 
		} else {
		
			*p = *string;
			p++;
			string++;
		}
        }
        *p = '\0'; 

        p = malloc(strlen(p_copy) + 1); 
        strcpy(p, p_copy); 
        free(p_copy); 

        return p;
}
