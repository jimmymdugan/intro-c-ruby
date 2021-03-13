#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "polygon.h"

/*
 * Allocates space for polygon struct, and for the name
 * Copies the name into the polygon struct
 * Returns a pointer to the new polygon.
 *
 * NOTE: use strlcpy instead of strcpy
 */
polygon *init_polygon(char *name){
	//YOUR CODE HERE

	polygon *p = (polygon *)malloc(sizeof(polygon));
	p->head = NULL;
	p->name = (char *)malloc(sizeof(char)*100);
	strlcpy(p->name, name,( strlen(name)+1));
	return p;
	
}

/*
 * Initializes a coordinate struct. Called by push(..)
 * Allocates the struct
 * Assigns x and y
 * The next pointer is initializes to NULL
 * Return a pointer to the newly-initialized struct.
 */
coord *init_coord(float x, float y) {
	//YOUR CODE HERE

	coord *ord = (coord *)malloc(sizeof(coord));

	ord->x = x;
	ord->y = y;
	return ord;
	
}

/*
 * Returns the number of sides for the polygon.
 * This is (roughly) equal to the number of nodes, with some boundary cases
 *   A polygon with no points has zero sides
 *   A polygon with one point has zero sides
 *   A polygon with two points has one side
 *   A polygon with three points has three sides (etc.)
 *
 * You may assume that p is never null.
 */
int polygon_sides(polygon *p) {
    
	
	int count = 1;
    	
	if(p->head == NULL)
		return 0;
	
	
	coord *temp = p->head;
    

	while (temp->next != p->head) {
        //	++count;
        	temp = temp->next;
		++count;
    	}
    	
	if(count <= 1) 
		return 0;
    	else if(count == 2) 
		return 1;
    	else 
		return count;


}

/*
 * Returns the pointer to the LAST element of the linked list.
 * That is, the element that points to p->head
 *
 * If the list is empty, return NULL
 *
 * You may assume that p is never null.
 */
coord *find_last(polygon *p) {
	//YOUR CODE HERE
	
	
	if(p->head == NULL)
		return NULL;
	
	coord *temp  = p->head;
	
	
	while(temp->next != p->head){
	
		temp = temp->next;
		

	}


	return temp;

	

	

}

/*
 * Adds a new node to the list
 *
 * Treat this list like a stack, i.e,
 * the new node should become the head
 *
 * Call init_coord to create the new node.
 *
 * Tip: call find_last(..) to help with insertion
 *
 * You may assume that p is never null.
 */
void push(polygon *p, float x, float y) {
	//YOUR CODE HERE
	
	coord *newCoord = init_coord(x,y);
	
	newCoord->next = p->head;
	
//	p->head->next = find_last(p);
//	newCoord->next=p->head;
	
	p->head = newCoord;
	p->head->next = p->head;
	
}


