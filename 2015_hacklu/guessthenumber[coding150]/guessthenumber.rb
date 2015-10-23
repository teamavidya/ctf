require 'net/telnet'

module LCG
  module Common
    # The original seed of this generator.
    attr_reader :seed

    # Creates a linear congruential generator with the given _seed_.
    def initialize(seed)
      @seed = @r = seed
    end
  end

  # LCG::Berkeley generates 31-bit integers using the same formula
  # as BSD rand().
  class Berkeley
    include Common
    def rand
      @r = (1103515245 * @r + 12345) & 0x7fff_ffff
    end
  end
end

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
