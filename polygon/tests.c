#include <stdlib.h>
#include <stdio.h>
#include "polygon.h"

int passed = 0;
int failed = 0;


/*
 * Our own testing utilities. Do not edit.
 */
void assert_true(int should_be_true, char* fail_message) {
	 if(should_be_true) {
		 printf("\x1B[32m.\x1B[0m"); // green dot
		 passed++;
	 } else {
		 failed++;
		 printf("\x1B[31mFAIL\x1B[0m %s\n", fail_message);
	 }
}

/*
 * Our own testing utilities. Do not edit.
 */
void assert_float_eq(float exp, float actual, char* fail_message){
	if(abs(exp - actual) - 0.01){
	    printf("\x1B[32m.\x1B[0m"); // green dot
		passed++;
	} else {
		failed++;
		printf("\x1B[31mFAIL\x1B[0m %s\n", fail_message);
	}
}

void test_init_polygon(){
	polygon *p = init_polygon("our polygon");

	assert_true(p != NULL,
				"polygon should not be null after initted");
	assert_true(strcmp(p->name, "our polygon") == 0,
				"polygon name is copied in");
}

void test_initial_node_count(){
	polygon *p = init_polygon("triangle");

	assert_true(polygon_sides(p) == 0,
				"an empty polygon has zero sides");
}

void test_init_coord() {
	coord *c = init_coord(1.0,2.0);

	assert_float_eq(1.0, c->x,
			  "x should be initialized to 1.0");
	assert_float_eq(2.0, c->y,
			  "y should be initialized to 1.0");
	assert_true(c->next == NULL,
			  "next should be initialized to NULL");

}

void test_single_node_count_nopush(){
	polygon *p = init_polygon("dot");
	// Here we'll build the list WITHOUT push()
	coord *c1 = init_coord(0.0, 1.0);
	p->head = c1;
	c1->next = c1;

	assert_true(polygon_sides(p) == 0,
				"a single dot has no sides (without implementing push)");
}

void test_double_node_count_nopush(){
	polygon *p = init_polygon("line");
	// Here we'll build the list WITHOUT push()
	coord *c1 = init_coord(0.0, 1.0);
	coord *c2 = init_coord(2.0, 3.0);
	p->head = c1;
	c1->next = c2;
	c2->next = c1;

	assert_true(polygon_sides(p) == 1,
				"two points has one side (without implementing push)");
}

void test_single_node_count(){
	polygon *p = NULL;
	p = init_polygon("dot");
	push(p, 0.0, 0.0);

	assert_true(polygon_sides(p) == 0,
			    "a single dot has zero sides");
	assert_true(p->head==p->head->next,
				"a single node's next points to itself");
}

void test_find_last() {
	polygon *p = init_polygon("triangle");
	// Here we'll build the list WITHOUT push()
	coord *c1 = init_coord(0.0, 1.0);
	coord *c2 = init_coord(2.0, 3.0);
	coord *c3 = init_coord(4.0, 5.0);
	p->head = c1;
	c1->next = c2;
	c2->next = c3;
	c3->next = c1;

	assert_true(c3 == find_last(p),
				"last node in the list should be pointing to head");
}

void test_double_node_count(){
	polygon *p = init_polygon("line");
	push(p, 0.0, 0.0);
	push(p, 1.0, 1.0);

	assert_true(polygon_sides(p) == 1,
			    "line has one side");
	assert_true(p->head != p->head->next,
				"line has two distinct nodes");
	assert_true(p->head == p->head->next->next,
				"list is circular");
}

void test_triple_node_count() {
	polygon *p = init_polygon("triangle");
	push(p, 0.0, 1.0);
	push(p, 2.0, 3.0);
	push(p, 4.0, 5.0);

	assert_true(polygon_sides(p) == 3,
			    "triangle has three sides");
	assert_float_eq(4.0, p->head->x,
					"last node pushed should be head");
	assert_float_eq(0.0, p->head->next->next->x,
					"first node pushed should be last node in list");
	assert_true(p->head == p->head->next->next->next,
				"triangle list is circular");
}


int main() {
	printf("\nGreen dots mean 'test passed'\n");

	//ENABLE THESE TESTS INCREMENTALLY
	// test_init_polygon();
	// test_initial_node_count();
	// test_init_coord();
	// test_single_node_count_nopush();
	// test_double_node_count_nopush();
	// test_find_last();
	// test_single_node_count();
	// test_double_node_count();
	// test_triple_node_count();

	printf("\nTests completed. %i passed, %i failed.\n", passed, failed);

	if(failed > 0){
		// Note: the \x1B[31m is "red" and \x1B[0m is "reset color"
		printf("\x1B[31mSome tests failed\x1B[0m, not quite done.\n");
		return 1; // Not all of them passed
	} else {
		// Note: the \x1Bm is "green"
		printf("\x1B[32mAll tests passed!\x1B[0m\n");
		if(passed < 18){
			printf("\x1B[31mBUT! You're not done.\x1B[0m Uncomment more test methods in main().\n");
		}
		return 0;
	}

}
