---
title: Dijkstra's algorithm
published: 2009-04-16T15:34:46Z
categories: Math
tags: computer science,Edsger Dijkstra,shortest path algorithm
---

<a href="http://en.wikipedia.org/wiki/Dijkstra%27s_algorithm">Dijkstra's algorithm</a> for finding the shortest paths in a graph is a classical one that most students of computer science get to learn about, although I suspect few have actually read the original paper.  Published in the very first volume of the journal <a href="http://www.springer.com/math/cse/journal/211"><cite>Numerische Mathematik</cite></a> in 1959, an official copy of the three-page paper <cite>A Note on Two Problems in Connexion with Graphs</cite> is available from <a href="http://www.springerlink.com/content/uu8608u0u27k7256/">SpringerLink</a>, although you would have to be at an academic institution with a subscription or have a personal subscription to SpringerLink to download the paper.

<!--more-->

<h3>The problems</h3>

As the title of the paper suggests, the paper puts forward two similar algorithms for two related but distinct problems.  In Edsger Dijkstra's own words:

<blockquote>
We consider multiple nodes, some or all pairs of which are connected by a branch; the length of each branch is given. We restrict ourselves to the case where at least one path exists between any two nodes.  We now consider two problems.

<ol>
<li>Construct the tree of minimum total length between nodes.</li>
<li>Find the path of minimum total length between two given nodes.</li>
</ol>
</blockquote>

The first problem is the <a href="http://en.wikipedia.org/wiki/Minimum_spanning_tree">minimum spanning tree</a> problem.  No one calls the algorithm that Dijkstra suggested for finding the minimum spanning tree "Dijkstra's minimum spanning tree algorithm" because Robert Prim had already published it in 1957, so it is commonly known as <a href="http://en.wikipedia.org/wiki/Prim's_algorithm">Prim's algorithm</a> instead.  However, as it happens every so often in science, the algorithm was already discovered by VojtÄ›ch JarnÃ­k in 1930, which languished in obscurity until being rediscovered by Prim and Dijkstra.

The second problem is the <a href="http://en.wikipedia.org/wiki/Shortest_path_problem">shortest path problem</a>, and it is for this problem that Dijkstra has been assigned de facto ownership.  When somebody mentions "Dijkstra's algorithm", it refers to the algorithm he created for finding the shortest path between two nodes.  There is actually very little difference between finding the shortest path between two <em>specific</em> nodes and finding all the shortest paths from a specific node to <em>every</em> other node in the path: the algorithms are virtually identical, although the former can finish earlier.

<h3>Nostalgia</h3>

When reading Dijkstra's paper today, it is not hard to get a sense of how long ago it was written as a computer science paper.  For one thing, it simply states the problems, their significance being self-evident and nary a word trying to explain why they are important, which is hard to find in computer science papers written today.

More interestingly, there is a sense that internal memory was at a premium compared to external storage as Dijkstra tries to explain why his algorithms were better than alternative algorithms, reflecting how primitive computers were in his day.  The first computer programming languages were less than ten years old, so this may have been a reason not to use <a href="http://www.programming4scientists.com/2008/10/the-basics-ofpseudocode/">pseudocode</a> to express the algorithms.  And it would be years before <a href="http://en.wikipedia.org/wiki/Big_O_notation">asymptotic complexity</a> would become of widespread use in computer science, so Dijkstra's arguments for the efficiency of his algorithms were much more hand-wavy than it would have been if it were to be written today.

<h3>Significance</h3>

When sending packets over the network, an ISP or Internet backbone wants to minimize the time or cost that is required to send a packet.  This is basically a shortest path problem, so it is no surprise that Dijkstra's algorithm is so useful for network routing.  In fact, whenever a shortest path problem needs to be solved, whether by shortest we mean least cost, least time, least length, etc., the first algorithm that comes to mind is Dijkstra's algorithm.

Dijkstra's algorithm can also be used to illustrate the usefulness of certain exotic data structures such as the <a href="http://en.wikipedia.org/wiki/Fibonacci_heap">Fibonacci heap</a>.  And of course, it is taught to most students of computer science today as an example of a greedy graph algorithm.

