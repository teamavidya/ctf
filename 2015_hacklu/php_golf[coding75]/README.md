## Challenge

We get only 62 characters to convert the letters in a string into alternating upper and lower case:

```
"Hello World! Hallo Welt!"
```
becomes
```
"HeLlO wOrLd! HaLlO wElT!"
```

## Solution

Using a similar strategy to perl golf, we had a legit 63 character solution:

```php
<?=preg_replace("/[a-z]/ie",'$0&~" "^$u^=" "',$argv[1+$u=" "]);
```

But this is where we got stuck and couldn't cut it down anymore to 62 characters. So we decided to hack it and removed the /i which would only be valid for input which only has lowercase:

```php
<?=preg_replace("/[a-z]/i",'$0&~" "^$u^=" "',$argv[1+$u=" "]);
```

We got lucky and on our first try we got the flag.

**flag{perlgolfisbetter}**

## Notes
taw later came up with a legit 61 character PHP only solution:
```php
<?=preg_replace("/\pL/ie",'$0&~" "^$u^=" "',$argv[1+$u=" "]);
```

The master solution of the challenge was 57 characters!
```php
<?=preg_filter("/\pL/e",'($0|" ")^chr($m^=32)',$argv[1]);
```

## Solved by
taw, destiny, blanky
