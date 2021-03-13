#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>

#define FALSE (0)
#define TRUE  (1)

int main() {
	int tot_chars = 0 ;	/* total characters */
	int tot_lines = 0 ;	/* total lines */
	int tot_words = 0 ;	/* total words */
	int ch;


	while((ch=getchar())!=EOF){
		tot_chars++;

		if(isspace(ch)){
			tot_words++;

}

		if(ch == '\n'){
			tot_lines++;
}		

		printf("%3d%4d%4d\n",tot_lines,tot_words,tot_chars);;
}
	
    

	return 0 ;
}
