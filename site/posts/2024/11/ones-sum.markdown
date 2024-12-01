---
title: 1-1+1-1+1-1+... = ?
description: What is the 1-1+1-1+1-1+...?  One needs to clarify exactly what one means by it.
published: 2024-11-30
categories: Math
math: true
head-extra: <meta http-equiv="Refresh" content="10">
---

What is the value of 1-1+1-1+1-1+...?

<!--more-->

## Naive arguments {#naive}

\begin{align*}
  x & = 1 - 1 + 1 - 1 + \cdots \\
  1 - x & = 1 - 1 + 1 - 1 + \cdots \\
  x & = 1 - x \\
  2x & = 1 \\
  x & = \frac{1}{2}
\end{align*}

### Grouping terms {#group-terms}

\begin{align*}
1 - 1 + 1 - 1 + \cdots
& = (1-1) + (1-1) + \cdots \\
& = 0
\end{align*}

\begin{align*}
1 - 1 + 1 - 1 + \cdots
& = 1 + (-1 + 1) + (-1 + 1) + \cdots \\
& = 1
\end{align*}

\begin{align*}
1 - 1 + 1 - 1 + \cdots
& = (\frac{1}{2} + \frac{1}{2}) - (\frac{1}{2} + \frac{1}{2}) + (\frac{1}{2} + \frac{1}{2}) - \cdots \\
& = \frac{1}{2} + \frac{1}{2} - \frac{1}{2} - \frac{1}{2} + \frac{1}{2} + \frac{1}{2} - \cdots \\
& = \frac{1}{2} + (\frac{1}{2} - \frac{1}{2}) + (- \frac{1}{2} + \frac{1}{2}) + \cdots
\end{align*}

## Formal definitions

\[ \sum_{k=0}^\infty a_k = \lim_{n \to \infty} \sum_{k=0}^n a_k \]

\[ \sum_{k=0}^\infty (-1)^k \equiv \lim_{n \to \infty} \sum_{k=0}^n (-1)^k \]

\[ \sum_{k=0}^\infty (1 - 1) = \sum_{k=0}^\infty 0 = \lim_{n \to \infty} \sum_{k=0}^n 0 = 0 \]

\[ 1 + \sum_{k=0}^\infty (-1 + 1) = 1 + \sum_{k=0}^\infty 0 = 1 + \lim_{n \to \infty} \sum_{k=0}^n 0 = 1 \]

\[
\sum_{k=0}^n (-1)^k =
  \begin{cases}
    \sum_{k=0}^{\frac{n}{2}} (1-1) & = 0 & \text{ when \(n\) is even} \\
    1 + \sum_{k=0}^{\frac{n}{2}-1} (-1+1) & = 1 & \text{ when \(n\) is odd}
  \end{cases}
\]

\begin{align*}
\frac{1}{2} + \sum_{k=0}^\infty (-1)^k (\frac{1}{2} - \frac{1}{2})
& = \frac{1}{2} + \lim_{n \to \infty} \sum_{k=0}^n (-1)^k (\frac{1}{2} - \frac{1}{2}) \\
& = \frac{1}{2} + \lim_{n \to \infty} \sum_{k=0}^n 0 \\
& = \frac{1}{2}
\end{align*}

## Continuation {#continuation}

\[ 1 + x + x^2 + x^3 + \cdots = \sum_{n=0}^\infty x^n  = \frac{1}{1-x} \]

\[ \frac{1}{1-x} = \frac{1}{1 - (-1)} = \frac{1}{2} \]
