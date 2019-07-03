# In general terms the algorithm for calculating a leap year is as follows...
# A year will be a leap year if it is divisible by 4 but not by 100.
# If a year is divisible by 4 and by 100, it is not a leap year unless it is also divisible by 400.

print 'Please enter a year:'
initial_year = gets.to_i

if initial_year % 4 == 0 && initial_year % 100 != 0
  puts 'Leap year!'
elsif initial_year % 4 == 0 && initial_year % 100 == 0
  initial_year % 400 == 0 ? puts('Leap year!') : puts('Not a leap year')
else
  puts 'Not a leap year!'
end
