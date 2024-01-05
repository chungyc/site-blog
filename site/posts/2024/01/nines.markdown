---
title: 0.999...
published: 2024-01-30
categories: Math
math: true
---

\[ 0.999\ldots \overset{?}{=} 1 \]

<!--more-->

## Simple

\begin{align*}
x & = 0.999\ldots \\
10x & = 9.999\ldots \\
10x - x & = 9.999\ldots - 0.999\ldots \\
9x & = 9 \\
\end{align*}

\[ \therefore \; x = 1 \]

## Limits

\[ 0.999\ldots
 = \sum_{k = 1}^\infty \frac{9}{10^k}
 = \lim_{n \rightarrow \infty} \sum_{k = 1}^n \frac{9}{10^k}
\]

\begin{align*}
x_n &= \sum_{k=1}^n \frac{9}{10^k} \\
10x_n &= \sum_{k=0}^{n-1} \frac{9}{10^k} \\
10x_n - x_n &= \left( 9 + \sum_{k=1}^{n-1} \frac{9}{10^k} \right) - \left( \frac{9}{10^n} + \sum_{k=1}^{n-1} \frac{9}{10^k} \right) \\
9x_n &= 9 - \frac{9}{10^n} \\
x_n &= 1 - \frac{1}{10^n}
\end{align*}

For any \(\varepsilon > 0\), with \(\delta=\frac{1}{10^N}\)
it will be the case that \(\left| 1 - x_n \right|  = \frac{1}{10^n} < \delta\) for all \(n > N\).
In other words, \( \lim_{n \rightarrow \infty} x_n = 1 \).

\[ \therefore \; 0.999\ldots = \sum_{k = 1}^\infty \frac{9}{10^k} = \lim_{n \rightarrow \infty} x_n = 1 \]

## Lexicographical tokens

```
"0.99999999..."
```
