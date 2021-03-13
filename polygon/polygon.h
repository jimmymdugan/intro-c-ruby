#ifndef POLYGON_H
#define POLYGON_H

typedef struct _coord {
	float x;
	float y;
	struct _coord *next;
} coord;

typedef struct {
	coord *head;
	char *name;
} polygon;


extern polygon *init_polygon(char *name);
extern coord   *init_coord(float x, float y);
extern int polygon_sides(polygon *p);
extern coord *find_last(polygon *p);
extern void push(polygon *p, float x, float y);

#endif
