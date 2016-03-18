#####
# Student ID: 2013-11395
# Description: makefile for Homework 1.
# Usage: 
#   * make in: run IndegreCounter.jar on Hadoop to compute the in-degree for each node
#   * make out: run OutdegreeCounter.jar on Hadoop to compute the out-degree for each node
#   * make in_dist: run DegreeDistribution.jar on Hadoop to compute the in-degree distribution
#   * make out_dist: run DegreeDistribution.jar on Hadoop to compute the out-degree distribution 

all: in out in_dist out_dist

jar:
	hadoop com.sun.tools.javac.Main IndegreeCounter.java
	jar cf IndegreeCounter.jar IndegreeCounter*.class
	rm -rf IndegreeCounter*.class

in:
	hadoop jar IndegreeCounter.jar IndegreeCounter ./input ./output
#	hadoop fs -cat output/part-r-00000
#	hadoop fs -get output/part-r-00000 output.txt

out:

in_dist:

out_dist:

clean:
	rm -rf output*
	rm -rf *.jar
