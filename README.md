# FreshpaintInterview

One facet of our work is that Freshpaint observes events that happen at some source and must decide whether that event is something a customer wants to send to another tool. For example: on the web, we could see a link click; a customer can define a pattern that can be matched to tell Freshpaint that this link click is special, and should go to their Mixpanel account.

One really common use-case is to match events based on CSS Selectors. This is something that we have to do today, and it’s the basis of the exercise I will describe below.

Suppose you had a string of characters that represents something you’d like to match. Your goal is to write a match function that takes a pattern and a string to match against which:

Matches literal characters in the string (e.g. abc matches itself);
but allows optional characters (e.g. a?bc can match abc but also bc).
(In practice, we might end up matching larger and more complex patterns, like groups of classes; that’s out of scope for this exercise.)

Here’s some pseudocode to show how this would work:

```
# In any programming language you wish, write a function which looks like this:
#   matches(pattern, str): bool
# Given a pattern, and something to match, it returns true if there's a match.

# Literal characters should match each other, but not anything else
matches("abc", "abc") == true
matches("abc", "bc") == false

# If we see a question mark (?), which can only follow some other character,
# that means the previous character is optional. If we use "a?bc", our pattern
# matches above would both be true.
matches("a?bc", "abc") == true
matches("a?bc", "bc") == true

# We only want to make full matches. Although "ab" is contained in "abc",
# this should return false. Although all of "de" could be matched, the pattern
# of "def" is not fully satisfied.
matches("ab", "abc") == false
matches("def", "de") == false

# Optional matches take on interesting behavior when the matching character is
# the same as another matching character. How would you keep track of what you
# need to match for the following?
matches("aa?a", "aaa") == true
matches("aa?a", "aa") == true

# You can have any number of optional matches in a pattern as well.
matches("a?bc?d", "abcd") == true
matches("a?bc?d", "abd") == true
matches("a?bc?d", "acd") == false

# Below you'll find the full set of matches that we will use to test your code.
# All of these tests must pass for your work to be accepted.

matches("", "") == true
matches("", "abc") == false
matches("a", "a") == true
matches("a", "b") == false
matches("a?", "") == true
matches("a?", "a") == true
matches("a?", "ab") == false
matches("a?", "b") == false
matches("a?bc?d", "abd") == true
matches("a?bc?d", "acd") == false
matches("a?bc?d", "bbd") == false
matches("aa?a", "aa") == true
matches("aa?a", "aaa") == true
matches("aa?a", "aaab") == false
matches("ab", "abc") == false
matches("abc", "") == false
matches("abc", "a") == false
matches("abc", "abc") == true
matches("abc", "bc") == false
matches("def", "de") == false
```

We use Coderpad to send code back and forth for this exercise. Use this link to write your solution in Coderpad. You can either write your code fully in Coderpad, or work on your code in an editor of your choice and then paste it into Coderpad at the end. You can use any programming language you wish for the work. We don’t give any weight to using languages that are part of our tech stack, so you should choose something you’re comfortable with!

You could use regular expressions to solve this problem, but the challenge here is that you find a way to do the match without them. You do not need to optimize for performance in your solution; instead, focus on correctness.
