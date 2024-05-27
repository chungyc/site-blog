---
title: Numbers denser than real numbers
description: Are real numbers the densest numbers we can have?  No, we can define denser numbers.  We do not learn about any because we do not need numbers denser than real numbers, not because they cannot exist.
published: 2024-12-07
math: true
categories: Math
tags: numbers
---

Starting from natural numbers, one gets to use more and more dense number systems
to expand what numbers could be used for, from natural numbers to real numbers.
Unless one goes hardcore into certain areas of mathematics,
the real numbers are going to be the densest numbers you are going to encounter.
Does this mean that real numbers are as dense as they can get?

<!--more-->

*   Natural numbers \(\mathbb{N}\): 1, 2, 3, ...

*   Integers \(\mathbb{Z}\): ..., -2, -1, 0, 1, 2, ...

*   Rational numbers \(\mathbb{Q}\): \(\frac{1}{2}\), \(\frac{6}{11}\), ...

*   Real numbers \(\mathbb{R}\): \(\sqrt{2}\), \(e\), \(\pi\), ...

*   Is that it?  Is nothing denser possible?

This is not so, even if real numbers may be the densest numbers that could be _useful_
in almost any context.

## Denser numbers {#denser-numbers}

\[ \mathbb{D} = \{ (x,y) \mid x \in \mathbb{R}, y \in \mathbb{R} \} \]

\(x \in \mathbb{R}\), \(d = (x,0) \in \mathbb{D}\), then \(x \equiv d\).
In some sense, \(\mathbb{D}\) would be a strict superset of \(\mathbb{R}\).
For every \(x \in \mathbb{R}\), there is an infinite number of \(d \in \mathbb{D}\).

For two numbers \(d = (x,y) \in \mathbb{D}\) and \(d' = (x',y') \in \mathbb{D}\),

*   if \(x < x'\), then \(d < d'\)

*   if \(x = x'\)

    *  and if \(y < y'\), then \(d < d'\)
    
    *  and if \(y = y'\), then \(d = d'\)
    
    *  and if \(y > y'\), then \(d > d'\)
    
*   if \(x > x'\), then \(d > d'\)

Addition and multiplication could be defined as

\[ (x,y) + (x',y') = (x+x',y+y') \]
\[ (x,y) \times (x',y') = (x \times x', y \times y') \]

## More numbers {#higher-cardinality}

\[ \mathbb{M} = \{ f : \mathbb{N} \rightarrow \mathbb{R} \} \]

Basically, this is a formal way to define a number as an infinite sequence
of real numbers \((f(0), f(1), f(2), \ldots)\).

For two numbers \(f\) and \(g\),

*   if \(f(n) = g(n)\) for all \(n \in \mathbb{N}\), then \(f = g\)

*   otherwise, for \(n \in \mathbb{N}\) such that \(f(k) = g(k)\)
    for all \(k < n\) and \(f(n) \neq g(n)\)
    
    *   if \(f(n) < g(n)\), then \(f < g\)
    
    *   if \(f(n) > g(n)\), then \(f > g\)

Addition and multiplication can be defined as each real number from each sequence
being added or multiplied with each other:

\[ (f + g)(n) = f(n) + g(n) \]
\[ (f \times g)(n) = f(n) \times g(n) \]

## Usefulness {#utility}

Since almost everything intuitive can be modeled using polynomials or calculus,
where you do not need numbers denser than real numbers if you start from real numbers,
real numbers are as dense a number system as one would get for most people.

Polynomial equations with real number coefficients do not need numbers denser
than real numbers to always have a solution.  So instead of going denser,
we go sideways and extend real numbers to complex numbers \(\mathbb{C}\),
which is why we learn complex numbers after real numbers
and not some standard number system denser than real numbers.[^quaternions]
\(\mathbb{D}\) and \(\mathbb{M}\) can still be thought of forming a line,
but \(\mathbb{C}\) does not have a particularly meaningful order which
can form a line, only meaningfully forming a surface instead.

[^quaternions]: One can go sideways even further with quaternions, vectors, or matrices, but still not denser.

### \(0.999\ldots \neq 1\)? {#limit-of-nines}

No, these denser numbers do not give a rationale to consider 0.999... to be different from 1.

## Even denser {#surreal-numbers}

TODO: Talk about surreal numbers.
