## Challenge

We get only 45 characters to convert the letters in a string into alternating upper and lower case:

```
"Hello World! Hallo Welt!"
```
becomes
```
"HeLlO wOrLd! HaLlO wElT!"
```

## Solution

A legit 44 character solution which works for all given input:

```perl
$_=lc"@ARGV";s/[a-z]/$u^=" ";$&^$u/ige;print
```
Explanation:
`$_=lc"@ARGV"` is just `$_ = lowercase("#{@ARGV}")`

`print` without argument defaults to `print($_)`

`s/[a-z]/$u^=" ";$&^$u/ige` is $_.gsub!(/[a-z]/)

`$u^=" ";` means switch $u betwen ascii character 0 and ascii character 32 (space) every iteration

`$&^$u` xors with 32, which just so happens to be difference between ascii uppercase and lowercase chars

**flag{chosingaflagisthemostdifficultpart}**

## Solved by
taw
