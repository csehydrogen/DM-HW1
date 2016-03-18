set key top right box
set logscale xy 10
set format x "10^{%L}"
set format y "10^{%L}"
set yrange [1:1e8]
set xrange [1:1e7]
set ylabel "Count" offset 0,1
set terminal postscript enhanced eps 30 color

set xlabel "In-degree"
set output 'indegree_count.eps'
plot "indegree_count.txt" using 1:2 title "LiveJournal" pt 1 ps 1.5 lc 3 lw 2.5

set xlabel "Out-degree"
set output 'outdegree_count.eps'
plot "outdegree_count.txt" using 1:2 title "LiveJournal" pt 1 ps 1.5 lc 3 lw 2.5
