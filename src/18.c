#include <stdio.h>

//Can't reserve much memory on the stack!
#define BIG_NUMBER 50  

typedef struct {
    int x, y, z;
} Point;

Point add(Point p1, Point p2) {
    return (Point) {p1.x + p2.x, p1.y + p2.y, p1.z + p2.z};
}

int main() {
    int x, y, z;                                            //All even coordinates -> Square position
    int table[BIG_NUMBER][BIG_NUMBER][BIG_NUMBER] = {0};    //One of them odd -> The side between two squares along the axis
    Point sides[6] = {{1,0,0}, {-1,0,0}, {0,1,0}, {0,-1,0}, {0,0,1}, {0,0,-1}};
    int counter1 = 0;
    while (scanf("%d,%d,%d", &x, &y, &z) >= 0) {
        Point p = {2 + 2*x, 2 + 2*y, 2 + 2*z}; //Freak there was a 0 coordinate that crashed me
        table[p.x][p.y][p.z] = -1; //-1 means has square
        for (int side_n = 0; side_n < 6; side_n++) {
            Point side = add(p, sides[side_n]);
            table[side.x][side.y][side.z] += 1; //If >= 0 it's the count of sides
            counter1 += (table[side.x][side.y][side.z]==1)? 1 : -1;
        }
    }
    printf("Part 1: %d\n", counter1);

    Point stack[BIG_NUMBER*BIG_NUMBER*BIG_NUMBER];
    stack[0] = (Point) {0,0,0};
    table[1][1][1] = -2;
    int stack_pos = 0;
    int counter2 = 0;
    while (stack_pos >= 0) {
        Point p = stack[stack_pos];
        stack_pos -= 1;
        for (int side_n = 0; side_n < 6; side_n++) {
            Point side = add(p, sides[side_n]);
            Point new_p = add(side, sides[side_n]);
            if (new_p.x < 0 || new_p.x >= BIG_NUMBER || new_p.y < 0 || new_p.y >= BIG_NUMBER || new_p.z < 0 || new_p.z >= BIG_NUMBER) {
                continue;
            }
            if (table[side.x][side.y][side.z] == 1) {
                table[side.x][side.y][side.z] = -1; //Exterior surface
                counter2 += 1;
            }
            if (table[new_p.x][new_p.y][new_p.z] == 0) {
                table[new_p.x][new_p.y][new_p.z] = -2; //Add to the stack of the flood fill
                stack_pos += 1;
                stack[stack_pos] = new_p;
            }
        }
    }
    printf("Part 2: %d\n", counter2);
    return 0;
}
