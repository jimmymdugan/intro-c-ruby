/*
* hashmap - Implementation of a lookup table as a hashmap. The table maintains symbol/value
*           pairs with the symbol being used as the key. 
*
*           Example:   The pair  RED, 12  would use 'RED' in a hashing function to compute 
*           a bin number (or array index) at which the value '12' would be stored. To retrieve a 
*           value from the lookup table, the symbol 'RED' would be used as the key and yield the
*           the value '12'. If a new pair with the same key is inserted (RED, 23 for example), 
*           the new value replaces the existing value in the hashmap.
*
*           If two symbols hash to the same bin number, a 'collision' occurs. The (symbol, value) pair which
*           created the collision is then inserted at the START of a linked list for that bin number - i.e. each
*           bin number points to a unique list of (symbol, value) pairs. 
* 
*  YOUR NAME GOES HERE
*
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BINSIZE 11      /* number of hashmap bins (intentionally small to create collisions) */

struct binEntry { 
   struct binEntry *next;    /* next entry in the list */
   struct binEntry *prev;    /* previous entry in the list */
   char *symbol;             /* defined symbol name */
   char *value;              /* value of the symbol */
}; 

static struct binEntry *hashtable[BINSIZE];     /* table of binEntry pointers */
                                                /* this array is visible to all functions in this file */

/************************************************************
 hash - Create an unsigned integer hashvalue for a string 
 ( DO NOT EDIT THIS FUNCTION )
************************************************************/
 unsigned  int hash( char *s)
{
    unsigned int hashvalue;       

    for( hashvalue= 0; *s != '\0' ; s++)
          hashvalue = *s + 31 * hashvalue;
    return hashvalue % BINSIZE;
}

/********************************************************************
 lookup  - Given a symbol name, return a binEntry. Return NULL if not found
( DO NOT EDIT THIS FUNCTION )
 *******************************************************************/
struct binEntry *lookup( char *symbol) 
{
    struct binEntry  *entry;
      
    for( entry = hashtable[ hash(symbol)] ; entry != NULL ; entry = entry->next)
          if ( strcmp( symbol, entry->symbol) == 0)
                return entry;
    return NULL;

}

/****************************************************************
 insert  - Inserts a symbol/value pair into the hashmap. Existing symbols
           are updated with the new value. A pointer to the new entry is returned.
              
( DO NOT EDIT THIS FUNCTION )
 ***************************************************************/
struct binEntry *insert( char *symbol,  char *value) 
{ 
  struct binEntry *entry;
  unsigned int hashvalue;
  
  if (( entry=lookup(symbol)) == NULL ) {   	/* symbol not found, create new entry  */
          entry = (struct binEntry*) malloc( sizeof (struct binEntry));
          entry->symbol  = strdup( symbol);     /* create a duplicate of this symbol */
          hashvalue = hash( symbol );
          entry->next = hashtable[hashvalue];   /* new entries become the start of the chain */
          entry->prev = NULL;                   /* a NULL previous pointer means it is first on the list */
          if ( entry->next != NULL )            /* if there is an existing entry in this bin, set its prev pointer */
              (entry->next)->prev = entry;        
          hashtable[hashvalue] = entry;         /* this entry becomes the head of the list for this bin */          
    } else {                                    /* symbol exists, just update value */
          free( (void*) entry->value);          /* release memory for current value being replaced */
    }
    entry->value = strdup( value);              /* create a duplicate of the value for this entry */
    
    return entry;    
} 

/****************************************************************
 drop - Deletes a symbol/value entry from the hashmap. Delete
        request is ignored if the symbol is not found.
 ***************************************************************/

void drop( char *symbol )
{
  
struct binEntry *entry;

if ((entry = lookup(symbol)) != NULL){
    if (entry->prev != NULL){
      entry->prev->next = entry->next;
    }
   else {
       hashtable[hash(symbol)] = entry->next;
   }
    if (entry->next != NULL){
      entry->next->prev = entry->prev;
    }
    free((void*)entry);
}
return;
}


/**************************************************************************
 dump - Print the contents of the hashmap

( DO NOT EDIT THIS FUNCTION )
***************************************************************************/
void dump()
{ 
    unsigned int bin;
    struct binEntry *entry;
      
    printf("\n\n=== Hashmap Contents ===\n");
    printf("BIN\n");
    printf("---\n");
    for( bin=0 ; bin < BINSIZE ; bin++ ) 
    {
        printf( "%2d  ", bin+1);
        if ( hashtable[bin] == NULL )
            printf( "NULL");
        else {
            for( entry = hashtable[bin] ; entry != NULL ; entry = entry->next) {
                printf("( %s , %s )", entry->symbol, entry->value);
                if( entry->next != NULL)
                   printf(" --> ");
              }
          }
        printf("\n");
      }
    printf("\n\n");
    return;
}

/**************************************************************************
 main - function main begins program execution - no command line parameters 
***************************************************************************/
int main()
{ 
  struct binEntry tmpEntry;
  struct binEntry *entry = &tmpEntry;
  int i;
   
  for( i = 0 ;  i < BINSIZE ; i++ )               /* initialize each bin to point to an empty list */
        hashtable[ i ] = NULL;
   
  entry = insert( "RED", "6");         /* GOLD -> BLUE -> RED (same bin) */
  entry = insert( "BLUE", "7");
  entry = insert( "GOLD", "2");

  entry = insert("ORANGE", "3");       /* CYAN -> ORANGE (same bin) */
  entry = insert("CYAN", "5");

  entry = insert("GREEN", "1");        /* VIOLET -> GREEN (same bin) */
  entry = insert("VIOLET", "4");

  entry = insert("BLACK", "0");        /* BLACK (single entry) */
  dump();

  printf("Drop single entry (BLACK)");
  drop("BLACK");
  dump();

  printf("Drop first in list (CYAN)");
  drop("CYAN");
  dump();

  printf("Drop middle of list (BLUE)");
  drop("BLUE");
  dump();

  printf("Drop last in list (GREEN)");
  drop("GREEN");
  dump();

  printf("Drop invalid symbol (BROWN)");
  drop("BROWN");
  dump();

  return 0; /* indicates successful termination */

} /* end main */
