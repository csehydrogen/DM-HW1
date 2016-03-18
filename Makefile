#####
# Student ID: 2013-11395
# Description: makefile for Homework 1.
# Usage: 
#   * make in: run IndegreCounter.jar on Hadoop to compute the in-degree for each node
#   * make out: run OutdegreeCounter.jar on Hadoop to compute the out-degree for each node
#   * make in_dist: run DegreeDistribution.jar on Hadoop to compute the in-degree distribution
#   * make out_dist: run DegreeDistribution.jar on Hadoop to compute the out-degree distribution 

all: in out in_dist out_dist

in: node_indegree.txt

out: node_outdegree.txt

in_dist: indegree_count.txt

out_dist: outdegree_count.txt

node_indegree.txt: IndegreeCounter.jar problem.edge
	hadoop jar IndegreeCounter.jar IndegreeCounter problem.edge ./output
	hadoop fs -get output/part-r-00000 node_indegree.txt
	rm -rf output
	cat node_indegree.txt

node_outdegree.txt: OutdegreeCounter.jar problem.edge
	hadoop jar OutdegreeCounter.jar OutdegreeCounter problem.edge ./output
	hadoop fs -get output/part-r-00000 node_outdegree.txt
	rm -rf output
	cat node_outdegree.txt

indegree_count.txt: DegreeDistribution.jar node_indegree.txt
	hadoop jar DegreeDistribution.jar DegreeDistribution node_indegree.txt ./output
	hadoop fs -get output/part-r-00000 indegree_count.txt
	rm -rf output
	cat indegree_count.txt

outdegree_count.txt: DegreeDistribution.jar node_outdegree.txt
	hadoop jar DegreeDistribution.jar DegreeDistribution node_outdegree.txt ./output
	hadoop fs -get output/part-r-00000 outdegree_count.txt
	rm -rf output
	cat outdegree_count.txt

%.jar: %.java
	hadoop com.sun.tools.javac.Main $*.java
	jar cf $*.jar $**.class
	rm -rf $**.class

check: checker
	./checker problem.edge node_indegree.txt node_outdegree.txt indegree_count.txt outdegree_count.txt

checker: checker.cpp
	g++ -std=c++11 -o checker checker.cpp

plot: degreedist.plt indegree_count.txt outdegree_count.txt
	gnuplot degreedist.plt
	epstopdf indegree_count.eps
	epstopdf outdegree_count.eps

clean:
	rm -rf *.jar node_indegree.txt node_outdegree.txt indegree_count.txt outdegree_count.txt
	rm -rf checker
	rm -rf indegree_count.eps indegree_count.pdf outdegree_count.eps outdegree_count.pdf
	rm -rf output
