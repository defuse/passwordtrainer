# Ruby Password Trainer

require 'highline/import'

TIMES_TO_TYPE = 5
CHUNK_SIZE = 4

puts "This is a script that helps you memorize a password."
puts "WARNING: Make sure nobody is watching you while you use this script!"
print "\nYour password: "
password = gets.chop
password_chunks = password.split("").each_slice( CHUNK_SIZE ).to_a

def gets_noecho
  ask("") { |q| q.echo = false }
end

def clear
  system("clear")
end

def continue?(round)
  print "Round #{round} finished. Again? [Y/n] "
  return gets =~ /^y$/i
end

def chunks(num_chunks, password_chunks)
  password_chunks.each_cons( num_chunks ) do |portion|
    part = portion.join("")
    # Training
    left = TIMES_TO_TYPE
    while left > 0
      puts "Type \"#{part}\"  #{left} times..."
      input = gets_noecho
      if input == part 
        left -= 1
      else
        puts "WRONG! You typed \"#{input}\""
        left += 2 
      end
    end
    # Recall test
    left = TIMES_TO_TYPE
    wrong = false
    while left > 0 and not wrong
      clear
      puts "Type the same thing #{left} times..."
      input = gets_noecho
      if input != part
        wrong = true
      else
        left -= 1
      end
    end
    print ">> You got #{TIMES_TO_TYPE - left}/#{TIMES_TO_TYPE} right.\n\n"
    if wrong
      puts "Try again..."
      redo
    end
  end
end

round = 0
begin
  clear
  1.upto( password_chunks.length ) do |num_chunks|
    chunks(num_chunks, password_chunks)
  end
  round += 1
end while continue?( round )
