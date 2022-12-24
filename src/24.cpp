#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Point {
    public:
        int i, j;
        Point() {}
        Point(int i, int j) {
            this->i = i;
            this->j = j;
        }
        Point operator+(Point other) {
            return Point(this->i + other.i, this->j + other.j);
        }
        Point operator%(Point other) {
            return Point((this->i + other.i) % other.i, (this->j + other.j) % other.j); //Why negative modulos????
        }
        bool operator==(const Point &other) const {
            return this->i == other.i && this->j == other.j;
        }
        struct HashFunction
            {
            size_t operator()(const Point& point) const
            {
            size_t xHash = std::hash<int>()(point.i);
            size_t yHash = std::hash<int>()(point.j) << 1;
            return xHash ^ yHash;
            }
        };
};
void blizzard_step(unordered_map<char, vector<Point>> &blizzards, unordered_map<char, Point> &directions, Point mod) {
    for (auto &[key, val] : blizzards) {
        for (int i = 0; i < val.size(); i++) {
            val[i] = (val[i] + directions[key]) % mod;
        }
    }
}
void free_step(vector<vector<vector<int>>> &occupied, unordered_map<char, vector<Point>> &blizzards, int n, int m) {
    vector<vector<int>> occupied_now(n, vector<int>(m, 0));
    for (auto &[key, val] : blizzards) {
        for (Point p : val) {
            occupied_now[p.i][p.j] = 1;
        }
    }
    occupied.push_back(occupied_now);
}
int compute(unordered_map<char, vector<Point>> &blizzards, vector<vector<vector<int>>> &occupied, \
        unordered_map<char, Point> directions, Point mod, int n, int m, vector<Point> moves, Point start, Point end) {
    
    unordered_set<Point, Point::HashFunction> positions = {start};
    int minute = 0;
    while (true) {
        minute++;
        blizzard_step(blizzards, directions, mod);
        free_step(occupied, blizzards, n, m);
        unordered_set<Point, Point::HashFunction> new_positions = {};
        for (Point pos : positions) {
            for (Point move : moves) {
                Point new_point = pos + move;
                if (new_point == end) {
                    return minute;
                }
                if (new_point == start || (new_point.i >= 0 && new_point.i < n && new_point.j >= 0 && new_point.j < m && \
                        occupied.back()[new_point.i][new_point.j] == 0)) {
                    new_positions.insert(new_point);
                }
            }
        }
        positions = new_positions;
    }
}
int main() {
    string line;
    unordered_map<char, vector<Point>> blizzards;
    unordered_map<char, Point> directions = {{'>', Point(0, 1)}, {'<', Point(0, -1)}, {'v', Point(1, 0)}, {'^', Point(-1, 0)}};
    int i = -1;
    Point *start_ptr;
    while (cin >> line) {
        if (i == -1) {
            start_ptr = new Point(-1, line.find('.') - 1);
        }
        for (int j = 0; j < line.length(); j++) {
            if (line[j]=='>' || line[j]=='<' || line[j]=='v' || line[j]=='^') {
                blizzards[line[j]].push_back(Point(i, j - 1));
            }
        }
        i++;
    }
    Point start = *start_ptr;
    Point end = Point(i - 1, line.find('.') - 1);
    int n = i - 1, m = line.length() - 2;
    Point mod = Point(n, m);
    vector<Point> moves = {Point(0,0), Point(1,0), Point(-1,0), Point(0,1), Point(0,-1)};

    vector<vector<vector<int>>> occupied = {};
    free_step(occupied, blizzards, n, m);

    int minutes1 = compute(blizzards, occupied, directions, mod, n, m, moves, start, end);
    int minutes2 = compute(blizzards, occupied, directions, mod, n, m, moves, end, start);
    int minutes3 = compute(blizzards, occupied, directions, mod, n, m, moves, start, end);

    cout << "Part 1: " << minutes1 << "\n";
    cout << "Part 2: " << minutes1 + minutes2 + minutes3 << "\n";
}