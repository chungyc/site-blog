---
title: 1-1+1-1+1-1+... = ?
description: What is the 1-1+1-1+1-1+...?  One needs to first clarify exactly what one means by it.
published: 2025-01-31
categories: Math
math: true
---

What is the value of 1-1+1-1+1-1+...?
Depending on how exactly one defines the question, there are different answers.
This should not mean everyone should argue what the answer is.
It just means people need to be clear on what they are asking.

<!--more-->

## Naive arguments {#naive}

Here is a naive argument for \(1-1+1-\cdots=\frac{1}{2}\),
in the vein of naive arguments that \(0.333\ldots=\frac{1}{3}\).

\begin{align*}
  x & = 1 - 1 + 1 - 1 + \cdots \\
  1 - x & = 1 - 1 + 1 - 1 + \cdots \\
  x & = 1 - x \\
  2x & = 1 \\
  x & = \frac{1}{2}
\end{align*}

This argument assumes many things that are not necessarily true.
For example, it assumes that there exists an \(x\) in the first place
such that \(x = 1-1+1-\cdots\), that the \(x\) in the first equation
and the \(x\) in the second argument are the same, etc.
Similar assumptions happen to be true for \(0.333\ldots = \frac{1}{3}\),
but they are not for \(1-1+1-\cdots\).

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
& = \frac{1}{2} + (\frac{1}{2} - \frac{1}{2}) + (- \frac{1}{2} + \frac{1}{2}) + \cdots \\
& = \frac{1}{2}
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

For \(-1 < x < 1\),

\[ 1 + x + x^2 + x^3 + \cdots = \sum_{n=0}^\infty x^n  = \frac{1}{1-x} \]

So while \(\sum_{n=0}^\infty x^n\) itself is not defined at \(x=-1\),
its continuation outside of \(-1 < x < 1\) is defined at \(x=-1\),
and its value is

\[ \frac{1}{1-x} = \frac{1}{1 - (-1)} = \frac{1}{2} \]
