import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

class MyClass {

    public static int get_square(int[] position, int[][] cube_starts) {
        int i = position[0] / 50, j = position[1] / 50;
        for (int c = 0; c < cube_starts.length; c++) {
            if (cube_starts[c][0] == i && cube_starts[c][1] == j) {
                return c;
            }
        }
        return 0;
    }

    public static int move(ArrayList<String> mapa, int[] position, int facing, int num_moves, int n, int m, int[][] cube_starts) throws Exception {
        int[] position_tmp = {position[0], position[1]};
        int facing_tmp = facing;
        while (num_moves > 0) {
            int i = position_tmp[0], j = position_tmp[1];
            if (facing == 0) {
                j = (j + 1) % m;
            } else if (facing == 1) {
                i = (i + 1) % n;
            } else if (facing == 2) {
                j = (j - 1 + m) % m;
            } else {
                i = (i - 1 + n) % n;
            }
            int square = get_square(position_tmp, cube_starts);
            if (square != get_square(new int[]{i, j}, cube_starts)) { //I left my square
                int[] int_position = {i - 50*cube_starts[square][0], j - 50*cube_starts[square][1]};
                int[] new_int_position;
                int new_square = 0;
                if (square == 1) {
                    if (facing_tmp == 0) {
                        new_square = 2;
                        new_int_position = new int[]{int_position[0], 0};
                    }
                    else if (facing_tmp == 1) {
                        new_square = 3;
                        new_int_position = new int[]{0, int_position[1]};
                    }
                    else if (facing_tmp == 2) {
                        new_square = 5;
                        facing_tmp = 0;
                        new_int_position = new int[]{49 - int_position[0], 0};
                    }
                    else {
                        new_square = 4;
                        facing_tmp = 0;
                        new_int_position = new int[]{int_position[1], 0};
                    }
                }
                else if (square == 2) {
                    if (facing_tmp == 0) {
                        new_square = 6;
                        facing_tmp = 2;
                        new_int_position = new int[]{49 - int_position[0], 49};
                    }
                    else if (facing_tmp == 1) {
                        new_square = 3;
                        facing_tmp = 2;
                        new_int_position = new int[]{int_position[1], 49};
                    }
                    else if (facing_tmp == 2) {
                        new_square = 1;
                        new_int_position = new int[]{int_position[0], 49};
                    }
                    else {
                        new_square = 4;
                        new_int_position = new int[]{49, int_position[1]};
                    }
                }
                else if (square == 3) {
                    if (facing_tmp == 0) {
                        new_square = 2;
                        facing_tmp = 3;
                        new_int_position = new int[]{49, int_position[0]};
                    }
                    else if (facing_tmp == 1) {
                        new_square = 6;
                        new_int_position = new int[]{0, int_position[1]};
                    }
                    else if (facing_tmp == 2) {
                        new_square = 5;
                        facing_tmp = 1;
                        new_int_position = new int[]{0, int_position[0]};
                    }
                    else {
                        new_square = 1;
                        new_int_position = new int[]{49, int_position[1]};
                    }
                }
                else if (square == 4) {
                    if (facing_tmp == 0) {
                        new_square = 6;
                        facing_tmp = 3;
                        new_int_position = new int[]{49, int_position[0]};
                    }
                    else if (facing_tmp == 1) {
                        new_square = 2;
                        new_int_position = new int[]{0, int_position[1]};
                    }
                    else if (facing_tmp == 2) {
                        new_square = 1;
                        facing_tmp = 1;
                        new_int_position = new int[]{0, int_position[0]};
                    }
                    else {
                        new_square = 5;
                        new_int_position = new int[]{49, int_position[1]};
                    }
                }
                else if (square == 5) {
                    if (facing_tmp == 0) {
                        new_square = 6;
                        new_int_position = new int[]{int_position[0], 0};
                    }
                    else if (facing_tmp == 1) {
                        new_square = 4;
                        new_int_position = new int[]{0, int_position[1]};
                    }
                    else if (facing_tmp == 2) {
                        new_square = 1;
                        facing_tmp = 0;
                        new_int_position = new int[]{49 - int_position[0], 0};
                    }
                    else {
                        new_square = 3;
                        facing_tmp = 0;
                        new_int_position = new int[]{int_position[1], 0};
                    }
                }
                else {
                    if (facing_tmp == 0) {
                        new_square = 2;
                        facing_tmp = 2;
                        new_int_position = new int[]{49 - int_position[0], 49};
                    }
                    else if (facing_tmp == 1) {
                        new_square = 4;
                        facing_tmp = 2;
                        new_int_position = new int[]{int_position[1], 49};
                    }
                    else if (facing_tmp == 2) {
                        new_square = 5;
                        new_int_position = new int[]{int_position[0], 49};
                    }
                    else {
                        new_square = 3;
                        new_int_position = new int[]{49, int_position[1]};
                    }
                }
                i = 50*cube_starts[new_square][0] + new_int_position[0];
                j = 50*cube_starts[new_square][1] + new_int_position[1];
            }
            if (mapa.get(i).charAt(j) == '#') {
                return facing;
            }
            position_tmp[0] = i;
            position_tmp[1] = j;
            if (mapa.get(i).charAt(j) == '.') {
                position[0] = i;
                position[1] = j;
                facing = facing_tmp;
                num_moves--;
            }
        }
        return facing;
    }

    public static void main(String[] args) throws Exception {
        ArrayList<String> mapa = new ArrayList<String>();
        Scanner sc = new Scanner(System.in);
        String line = sc.nextLine();
        int m = 0;
        while (line != "") {
            mapa.add(line);
            if (line.length() > m) {
                m = line.length();
            }
            line = sc.nextLine();
        }
        int n = mapa.size();
        for (int i = 0; i < n; i++) {
            mapa.set(i, mapa.get(i) + " ".repeat(m - mapa.get(i).length()));
        }
        int position[] = {0, 0}, facing = 0;
        while (mapa.get(position[0]).charAt(position[1]) != '.') {
            position[1]++;
        }
        String password = sc.nextLine();
        sc.close();
        int[] moves = Arrays.stream(password.split("[RDLU]")).mapToInt(Integer::parseInt).toArray();
        String[] directions = password.split("[0-9]+");

        int[][] cube_starts = {{0, 0}, {0, 1}, {0, 2}, {1, 1}, {3, 0}, {2, 0}, {2, 1}};

        facing = move(mapa, position, facing, moves[0], n, m, cube_starts);
        for (int op_numb = 1; op_numb < moves.length; op_numb++) {
            facing = (facing + ((directions[op_numb].charAt(0)=='R')? 1 : -1) + 4) % 4; //Why negative modulos too???
            facing = move(mapa, position, facing, moves[op_numb], n, m, cube_starts);
        }
        System.out.println(1000*(position[0]+1) + 4*(position[1]+1) + facing); //13566 too low part 2
    }
}
