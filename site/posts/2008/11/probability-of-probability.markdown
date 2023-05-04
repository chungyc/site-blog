---
title: The probability of a probability
published: 2008-11-05T11:07:42Z
categories: Math
tags: conditional probability,probability
---

[mathjax]

The <a href="http://diracseashore.wordpress.com/2008/11/05/probabilities-in-physics/">Shores of the Dirac Sea</a> has a somewhat <a href="http://diracseashore.wordpress.com/2008/11/05/probabilities-in-physics/">head-scratching puzzle about probabilities</a>:
<blockquote cite="http://diracseashore.wordpress.com/2008/11/05/probabilities-in-physics/">
Let us say that someone gives you a lopsided bet.  Say that with probability \(r\) one gets heads, and with probability \(1-r\) one gets tails, and you have to pick heads or tails.  You only know the outcome of the first event.  Let's say after the first toss it came out heads. What is the probability that \(r &gt; \frac{1}{2}\)?</blockquote>
<!--more-->

At first glance, the question makes no sense.  The outcome of a bet is determined by the probability, so what is it with asking about the probability of the <em>probability</em>?  Maybe rephrasing the question might make it a bit more clearer:
<blockquote>
Given that the probability of a head is \(r\), the probability of a head is \(r\).  Given that a single toss ended up a head, what was the probability that \(r&gt; \frac{1}{2}\)?</blockquote>
The first sentence might seem blatantly redundant, and you might be confused about what's different with the second sentence.  If it doesn't make sense to you, thinking a lot harder is one way to figure out the difference, but another way is to learn about <a href="http://en.wikipedia.org/wiki/Conditional_probability">conditional probabilities</a>.  For the more mathematically inclined, expressing the problem in formulas makes the difference even more apparent, not to mention explaining the apparent redundancy:

[latex] P(H \,|\, p=r) = r [/latex]
[latex] P(p=r \,|\, H) = \, ? [/latex]

Given this reformulation, all you have to do is to take advantage of the properties of conditional probabilities:

[latex] P(r &gt; \frac{1}{2} \,|\, H) = \frac{P(r &gt; \frac{1}{2} \,\wedge\, H)}{P(H)} [/latex]

Embarrassingly, my first answer ended up being \(\frac{1}{2}\):

[latex] \frac{P(r &gt; \frac{1}{2} \wedge H)}{P(H)} \not= \int_\frac{1}{2}^1 \frac{r \, dr}{r} = \frac{1}{2} [/latex]

I confused \(P(H)\) with \(P(H|p=r)\), which led me to the obvious-looking and yet seemingly wrong answer.  (It's <em>because</em> \(\frac{1}{2}\) is such an obvious guess that it seems so wrong, given my experience with conditional probabilities.)  The denominator and numerator have to be computed separately, but I foolishly didn't do so.  Since the probability of a head being <em>exactly</em> \(r\) is \(dr\), in which case the probability of a head is \(r\), the probability of \(p=r\) and a head simultaneously is \(r \, dr\).  (Not being a pure mathematician, I'll live with the bit of fudging here.)  And since \(P(H) = P(r \geq 0 \,\wedge\, H)\):

[latex] P(p &gt; \frac{1}{2} \,|\, H) = \frac{P(r &gt; \frac{1}{2} \,\wedge\, H)}{P(H)} = \frac{\int_\frac{1}{2}^1 r \, dr}{\int_0^1 r \, dr} = \frac{3}{4} [/latex]

So the probability of the probability of a head coming up being larger than 0.5, given that a single toss turned out to be a head, ends up being 0.75.  This probability is much more in line with what I would expect when working with conditional probabilities.

The next time you come across a brand new sort of coin that no one has ever seen before, and a single toss ends up being a head, you can confidently say that it's much more likely to be biased towards heads.  Of course in real life, most of the coins you see will be like every other coin you've seen before, and all of them probably turned out to be fair, so all of this doesn't apply.  On the other hand, there are other sorts of practical problems you can apply the same sort of reasoning to.

