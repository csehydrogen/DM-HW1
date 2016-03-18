#####
# Student ID: 2013-11395
# Description: makefile for Homework 1.
# Usage: 
#   * make in: run IndegreCounter.jar on Hadoop to compute the in-degree for each node
#   * make out: run OutdegreeCounter.jar on Hadoop to compute the out-degree for each node
#   * make in_dist: run DegreeDistribution.jar on Hadoop to compute the in-degree distribution
#   * make out_dist: run DegreeDistribution.jar on Hadoop to compute the out-degree distribution 

all: in out in_dist out_dist

jar: IndegreeCounter.jar OutdegreeCounter.jar

IndegreeCounter.jar: IndegreeCounter.java
	hadoop com.sun.tools.javac.Main IndegreeCounter.java
	jar cf IndegreeCounter.jar IndegreeCounter*.class
	rm -rf IndegreeCounter*.class

OutdegreeCounter.jar: OutdegreeCounter.java
	hadoop com.sun.tools.javac.Main OutdegreeCounter.java
	jar cf OutdegreeCounter.jar OutdegreeCounter*.class
	rm -rf OutdegreeCounter*.class

in:
	hadoop jar IndegreeCounter.jar IndegreeCounter ./input ./output
#	hadoop fs -cat output/part-r-00000
#	hadoop fs -get output/part-r-00000 output.txt

out:
	hadoop jar OutdegreeCounter.jar OutdegreeCounter ./input ./output
#	hadoop fs -cat output/part-r-00000
#	hadoop fs -get output/part-r-00000 output.txt

in_dist:

out_dist:

clean:
	rm -rf output*
	rm -rf *.jar
