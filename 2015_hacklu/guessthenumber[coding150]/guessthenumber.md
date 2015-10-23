## Challenge

The teacher of your programming class gave you a tiny little task: just write a guess-my-number script that beats his script. He also gave you some hard facts:

  - he uses some LCG with standard glibc LCG parameters
  - the LCG is seeded with server time using number format YmdHMS (python strftime syntax)
  - numbers are from 0 up to (including) 99
  - numbers should be sent as ascii string

You can find the service on school.fluxfingers.net:1523

If we telnet or netcat to the service we see:

```
$ nc school.fluxfingers.net 1523
Welcome to the awesome guess-my-number game!
It's 22.10.2015 today and we have 01:22:03 on the server right now. Today's goal is easy:
just guess my 100 numbers on the first try within at least 30 seconds from now on.
Ain't difficult, right?
Now, try the first one:
42
Wrong! You lost the game. The right answer would have been '63'. Quitting.
```

## Solution

After some googling we find LCG code here which we can use http://rosettacode.org/wiki/Linear_congruential_generator. However, the size of the numbers output is too big for what we need so we can assume that mod 100 is used. After inspecting the generated array we see that the first number expected by the the game is the last number in the array, so we simply reverse the array then submit the answer.

```ruby
# Connect then wait for the game to begin
connection = Net::Telnet::new("Host" => "school.fluxfingers.net", "Timeout" => 10, "Port" => "1523")

datetime = "20151022"
msg = connection.waitfor(/Now, try the first one:/) { |c| puts c }

# Get the time from the game message and append to the date
msg = msg.split("\n")
datetime << msg[1][34..-49]
datetime = datetime.delete(":").to_i

# Use datetime as the seed and save the numbers in reverse order
lcg = LCG::Berkeley.new(datetime)
nums = (0..99).map {lcg.rand % 100} # mod 100 here
nums = nums.reverse
p nums

# Sumbit each number, waiting for the service to return the expected string before entering the next number
nums.each do |num|
  connection.cmd("String" => num.to_s, "Match" => /Correct!/) { |c| print c }
end
```

![][guessthenumber.png]

Full code [here](guessthenumber_solved.png).

**flag{don't_use_LCGs_for_any_guessing_competition}**

## Solved by
destiny
