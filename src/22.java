import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

class MyClass {

    public static int move(ArrayList<String> mapa, int[] position, int facing, int num_moves, int n, int m) {
        int[] position_tmp = {position[0], position[1]};
        while (num_moves > 0) {
            int i = position_tmp[0], j = position_tmp[1];
            if (facing == 0) {
                j = (j + 1) % m;
            } else if (facing == 1) {
                i = (i + 1) % n;
            } else if (facing == 2) {
                j = (j - 1 + m) % m;
            } else if (facing == 3) {
                i = (i - 1 + n) % n;
            } else {
                System.out.println("FFFF");
            }
            if (mapa.get(i).charAt(j) == '#') {
                return facing;
            }
            position_tmp[0] = i;
            position_tmp[1] = j;
            if (mapa.get(i).charAt(j) == '.') {
                position[0] = i;
                position[1] = j;
                num_moves--;
            }
            
        }
        return facing;
    }

    public static void main(String[] args) {
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
        facing = move(mapa, position, facing, moves[0], n, m);
        for (int op_numb = 1; op_numb < moves.length; op_numb++) {
            facing = (facing + ((directions[op_numb].charAt(0)=='R')? 1 : -1) + 4) % 4; //Why negative modulos too???
            facing = move(mapa, position, facing, moves[op_numb], n, m);
        }
        System.out.println(1000*(position[0]+1) + 4*(position[1]+1) + facing); //13566 too low part 2
    }
}
