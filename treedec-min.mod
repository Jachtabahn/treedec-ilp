/*********************************************
* OPL 12.9.0.0 Model
* Author: habimm
* Creation Date: Nov 9, 2019 at 9:53:32 PM
*********************************************/

int NumVertices = ...;
int NumEdges = ...;
int Edges[1..NumEdges][1..2] = ...;
int Width = ...;

range Vertices = 1..NumVertices;
dvar int ordering[Vertices][Vertices] in 0..1;
dvar int edge[Vertices][Vertices] in 0..1;

minimize
  max (u in Vertices) sum (v in Vertices) edge[u][v];

subject to {
  forall (u in Vertices)
    ordering[u][u] == 0;

  forall (u in Vertices)
    edge[u][u] == 0;

  forall (u in Vertices, v in Vertices)
    if (u != v) { ordering[u][v] + ordering[v][u] == 1; }

  forall (u in Vertices, v in Vertices, w in Vertices)
    ordering[u][v] + ordering[v][w] - ordering[u][w] <= 1;

  forall (u in Vertices, v in Vertices)
    edge[u][v] + edge[v][u] <= 1;

  forall (u in Vertices, v in Vertices, w in Vertices)
    if (v != w) { edge[u][v] + edge[u][w] - edge[v][w] - edge[w][v] <= 1; }

  forall (u in Vertices, v in Vertices)
    ordering[u][v] + edge[v][u] <= 1;

  forall (e in 1..NumEdges)
    edge[Edges[e][1]][Edges[e][2]] + edge[Edges[e][2]][Edges[e][1]] >= 1;
}
