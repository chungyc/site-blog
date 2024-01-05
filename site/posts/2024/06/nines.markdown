---
title: 0.999...
description:
  For a sane definition of 0.999..., it should be equal to 1,
  but one could give up nice things so that 0.999... is not equal to 1.
published: 2024-06-01
categories: Math
math: true
---

Among the mathematically literate, this is not in contention at all,
but for some reason whether 0.999... with infinitely repeating nines is equal to one
is a perennial source of great controversy for a lot of people.

<!--more-->

\[ 0.999\ldots \overset{?}{=} 1 \]

## They are the same

### Simple

\begin{align*}
x & = 0.999\ldots \\
10x & = 9.999\ldots \\
10x - x & = 9.999\ldots - 0.999\ldots \\
9x & = 9 \\
\end{align*}

\[ \therefore \; x = 1 \]

### Limits

\[ 0.999\ldots
 = \sum_{k = 1}^\infty \frac{9}{10^k}
 = \lim_{n \rightarrow \infty} \sum_{k = 1}^n \frac{9}{10^k}
\]

\begin{align*}
x_n &= \sum_{k=1}^n \frac{9}{10^k} \\
10x_n &= \sum_{k=0}^{n-1} \frac{9}{10^k} \\
10x_n - x_n &= \left( 9 + \sum_{k=1}^{n-1} \frac{9}{10^k} \right)
- \left( \frac{9}{10^n} + \sum_{k=1}^{n-1} \frac{9}{10^k} \right) \\
9x_n &= 9 - \frac{9}{10^n} \\
x_n &= 1 - \frac{1}{10^n}
\end{align*}

For any \(\varepsilon > 0\), with \(\delta=\frac{1}{10^N}\)
it will be the case that \(\left| 1 - x_n \right|  = \frac{1}{10^n} < \delta\) for all \(n > N\).
In other words, \( \lim_{n \rightarrow \infty} x_n = 1 \).

\[ \therefore \; 0.999\ldots = \sum_{k = 1}^\infty \frac{9}{10^k} = \lim_{n \rightarrow \infty} x_n = 1 \]

## What's the difference?

*   What is \(1 - 0.999\ldots\)?
*   Does \(x - y = 0\) imply \(x = y\)?

### Infinitesimals

## They are not the same

### Strings

```
"1"
```

```
"0.99999999..."
```

`"1"` would be different from `"01"` and `"1.0"`.

#### "Canonical" infinite strings

```
"...001.000..."
```

\[ f_\mathrm{one}(k) =
\begin{cases}
0 & \text{ for } k > 0 \\
1 & \text{ for } k = 0 \\
0 & \text{ for } k < 0
\end{cases}
\]

```
"...000.999..."
```

\[ f_\mathrm{nines}(k) =
\begin{cases}
0 & \text{ for } k \geq 0 \\
9 & \text{ for } k < 0
\end{cases}
\]

### Sequence of sequences

1.000...

\[ ([[1]],[]) \]

0.999...

\[ ([0],[[9,9,9,\ldots]]) \]

0.000...1

\[ ([0],[[0,0,0,\ldots], [1]]) \]

## Having nice things
