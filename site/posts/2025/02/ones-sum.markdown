---
title: 1-1+1-1+1-1+... = ?
description: What is the 1-1+1-1+1-1+...?  One needs to first clarify exactly what one means by it.
published: 2025-02-27
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
but these are not true for \(1-1+1-\cdots\).

### Grouping terms {#group-terms}

In fact, the situation is even worse than the naive argument being based
on unwarranted assumptions.  Other naive arguments can result in different answers,
which is different from what we expect from the addition and subtraction
of a finite amount of numbers.  For example, just by grouping the terms
differently, it could be argued that the answers could be 0 or 1.

By grouping the first and second terms, the third and fourth terms, the fifth
and sixth terms, etc., one might conclude that \(1-1+1-\cdots=0\).

\begin{align*}
1 - 1 + 1 - 1 + \cdots
& = (1-1) + (1-1) + \cdots \\
& = 0 + 0 + \cdots \\
& = 0
\end{align*}

On the other hand, by grouping the second and third terms, the fourth and fifth
terms, the sixth and seventh terms, etc., one could alternatively conclude that
\(1-1+1-\cdots=1\).

\begin{align*}
1 - 1 + 1 - 1 + \cdots
& = 1 + (-1 + 1) + (-1 + 1) + \cdots \\
& = 1 + 0 + 0 + \cdots \\
& = 1
\end{align*}

The possible answers do not end there.  By breaking up each 1 into two \(\frac{1}{2}\) added together
and rearranging terms, we could also naively conclude that \(1-1+1-\cdots=\frac{1}{2}\),
just as we had concluded from the first naive argument in this article.

\begin{align*}
1 - 1 + 1 - 1 + \cdots
& = (\frac{1}{2} + \frac{1}{2}) - (\frac{1}{2} + \frac{1}{2}) + (\frac{1}{2} + \frac{1}{2}) - \cdots \\
& = \frac{1}{2} + \frac{1}{2} - \frac{1}{2} - \frac{1}{2} + \frac{1}{2} + \frac{1}{2} - \cdots \\
& = \frac{1}{2} + (\frac{1}{2} - \frac{1}{2}) + (- \frac{1}{2} + \frac{1}{2}) + \cdots \\
& = \frac{1}{2} + 0 + 0 + \cdots \\
& = \frac{1}{2}
\end{align*}

It is not that there are inconsistent answers for the same question.
The answers are all different because they are actually answering different questions.

## Formal definitions

To properly answer what the value of \(1-1+1-\cdots\) is,
we need to nail down _precisely_ what we are talking about.
The standard treatment for a sum of an infinite count of numbers
is to use a limit of a partial sum of \(n\) numbers as \(n\) goes to infinity.

\[ \sum_{k=0}^\infty a_k = \lim_{n \to \infty} \sum_{k=0}^n a_k \]

We can think of \(1-1+1-\cdots\) as the limit of the sum of alternating ones and negative ones,
which would be the most straightforward way to think of the problem.

\[ \sum_{k=0}^\infty (-1)^k \equiv \lim_{n \to \infty} \sum_{k=0}^n (-1)^k \]

The sequence of the sums goes like \(1\), \(1-1=0\), \(1-1+1=1\), \(1-1+1-1=0\), etc.
In other words, the sequence of sums goes like 1, 0, 1, 0, 1, 0, ..., which never gets
arbitrarily close to any single number, which means the limit does not exist.
This knocks the legs out of a basic assumption used by the initial naive
argument, in that a value \(x=1-1+1-\cdots\) does not exist in the first place.

\[
\sum_{k=0}^n (-1)^k =
  \begin{cases}
    \sum_{k=0}^{\frac{n}{2}} (1-1) & = 0 & \text{ when \(n\) is even} \\
    1 + \sum_{k=0}^{\frac{n}{2}-1} (-1+1) & = 1 & \text{ when \(n\) is odd}
  \end{cases}
\]

What about the values derived by grouping the terms in particular ways?
The implicit assumptions in these cases are mostly true,
but the different values are also answers to _different_ questions.
One is the limit of the sequence \((1-1)\), \((1-1)+(1-1)\), \((1-1)+(1-1)+(1-1)\), ...,
another is the limit of the sequence \(1\), \(1+(-1+1)\), \(1+(-1+1)+(-1+1)\), ...,
and the last is the limit of the sequence \(\frac{1}{2}\), \(\frac{1}{2}+(\frac{1}{2}-\frac{1}{2})\),
\(\frac{1}{2}+(\frac{1}{2}-\frac{1}{2})+(-\frac{1}{2}+\frac{1}{2})\), ...

\[ \sum_{k=0}^\infty (1 - 1) = \sum_{k=0}^\infty 0 = \lim_{n \to \infty} \sum_{k=0}^n 0 = 0 \]

\[ 1 + \sum_{k=0}^\infty (-1 + 1) = 1 + \sum_{k=0}^\infty 0 = 1 + \lim_{n \to \infty} \sum_{k=0}^n 0 = 1 \]

\begin{align*}
\frac{1}{2} + \sum_{k=0}^\infty (-1)^k (\frac{1}{2} - \frac{1}{2})
& = \frac{1}{2} + \lim_{n \to \infty} \sum_{k=0}^n (-1)^k (\frac{1}{2} - \frac{1}{2}) \\
& = \frac{1}{2} + \lim_{n \to \infty} \sum_{k=0}^n 0 \\
& = \frac{1}{2}
\end{align*}

The one problematic assumption is the assumption that one can group terms in an
infinite sequence freely.  Unlike with the addition of a finite count of numbers,
it is _not_ necessarily the case that one can move terms around freely to obtain
an equivalent sum with a sum of an infinite sequence.  This boils down to the fact
that it is _not_ necessarily true that \(\sum_{k=0}^\infty (a_k + b_k) = \sum_{k=0}^\infty a_k + \sum_{k=0}^\infty b_k\).
This is true if all three limits exist, but it is not if any do not exist.
Contrast this with the fact that it is always the case that \(\sum_{k=0}^n (a_k+b_k) = \sum_{k=0}^n a_k + \sum_{k=0}^n b_k\)
for sums of finite sequences.

What this means is that the different ways of grouping the terms are not different ways
to derive the value for the same sum, but are actually deriving the value for _different_ sums,
which is why it is possible for them to have different answers.

One caveat to all this is that we are using the standard understanding of
limits and sums of infinite sequences to define the problem.
With a different framework, it may in fact be possible to have a definite
value for \(1-1+1-\cdots\), but then this would be a different question,
and goes back to how we should make it precise as to what we are actually asking.

## Continuation {#continuation}

As an example of a different framework with which to ask the question,
we could think in terms of finding an algebraic function which gives the
same results as \(1+x+x^2+x^3+\cdots\) when the latter exists with the
standard understanding of sums of infinite sequences,
and define the value to be the value of the algebraic function
when the sum does not exist with the standard understanding.

For \(-1 < x < 1\), it is the case that

\[ 1 + x + x^2 + x^3 + \cdots = \sum_{n=0}^\infty x^n  = \frac{1}{1-x} \]

So while \(\sum_{n=0}^\infty x^n\) itself is not defined at \(x=-1\),
its continuation outside of \(-1 < x < 1\) is defined at \(x=-1\),
and its value is

\[ \frac{1}{1-x} = \frac{1}{1 - (-1)} = \frac{1}{2} \]

So with this framework for asking the question, \(1-1+1-\cdots\) would be equal to \(\frac{1}{2}\).

## Who wins? {#correct-answer}

After all that has been said, what is the correct answer for \(1-1+1-\cdots\)?
The answers that it does not exist, that it is 0, that it is 1, or that it is \(\frac{1}{2}\)
are _all_ correct depending on exactly what we mean by the question.
It is not that there is one right way to derive the answer,
and all the other plausible derivations are wrong,
but that they are all separate answers to separate questions.

As long as one asks a mathematical question precisely enough,
it will usually be the case that there is only one correct answer,
but it can be interesting to change the question in various ways, too.
This can be a way to create interesting mathematics,
the same way that the value for \(1+2+3+4+5+\cdots\) can be said
to exist meaningfully with the value \(-\frac{1}{12}\)
if we think about the sum in different ways.
