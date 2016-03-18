#include <cstdio>
#include <cstdlib>
#include <map>
using namespace std;
int main(int argc, char **argv) {
    if (argc != 6) {
        printf("Usage: ./check problem.edge node_indegree.txt node_outdegree.txt indegree_count.txt outdegree_count.txt\n");
        exit(1);
    }

    FILE *f;
    int x, y;
    map<int, int> in, out;

    f = fopen(argv[1], "r");
    while (fscanf(f, "%d%d", &x, &y) == 2) {
        ++out[x];
        ++in[y];
    }
    fclose(f);

    f = fopen(argv[2], "r");
    while (fscanf(f, "%d%d", &x, &y) == 2) {
        if (in[x] != y) {
            printf("Indegree of node %d is %d, not %d\n", x, in[x], y);
            exit(1);
        }
    }
    fclose(f);

    f = fopen(argv[3], "r");
    while (fscanf(f, "%d%d", &x, &y) == 2) {
        if (out[x] != y) {
            printf("Outdegree of node %d is %d, not %d\n", x, out[x], y);
            exit(1);
        }
    }
    fclose(f);

    map<int, int> incnt, outcnt;
    for (auto &i: in)
        ++incnt[i.second];
    for (auto &i: out)
        ++outcnt[i.second];

    f = fopen(argv[4], "r");
    while (fscanf(f, "%d%d", &x, &y) == 2) {
        if (incnt[x] != y) {
            printf("# of node of indegree %d is %d, not %d\n", x, incnt[x], y);
            exit(1);
        }
    }
    fclose(f);

    f = fopen(argv[5], "r");
    while (fscanf(f, "%d%d", &x, &y) == 2) {
        if (outcnt[x] != y) {
            printf("# of node of outdegree %d is %d, not %d\n", x, outcnt[x], y);
            exit(1);
        }
    }
    fclose(f);

    printf("Valid.\n");

    return 0;
}
