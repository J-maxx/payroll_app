#require 'labor_rates.rb'

class Payroll
  attr_accessor :rate, :call, :wrap, :lunch, :dinner

  def initialize(*args)
    @rate     = rate
    @call     = call
    @wrap     = wrap
    @lunch    = lunch
    @dinner   = dinner
  end
  
  def crew_details
    puts "\n Please enter your:".upcase
    instance_variables.each do |i|
      print "\n #{i.to_s.sub('@','').upcase}: "
      instance_variable_set(i, gets.chomp.to_f)
    end
  end
  
  def elapsed_hours
    @wrap - @call
  end
  
  def work_hours
    elapsed_hours - meals
  end
  
  def meals
    @lunch + @dinner
  end

  def straight_time
    8 unless work_hours == 0
  end
  
  def overtime
    if (8.1..14).include? work_hours
      work_hours - straight_time
    else
      work_hours > 14 ? 6 - meals : 0
    end
  end
  
  def golden_time
    work_hours > 14 ? elapsed_hours - triple_time - 14 : 0
  end
  
  def triple_time
    work_hours > 15 ? work_hours - 15 : 0
  end
  
  def pay_hours
      straight_time + (1.5 * overtime) + (2 * golden_time) + (3 * triple_time)
  end

  def daily_pay
    pay_hours * @rate
  end
end

crew = Payroll.new

crew.crew_details

puts %| 
Elapsed hours: #{crew.elapsed_hours}

Total meals deducted: #{crew.meals}

Total hours worked: #{crew.work_hours}

Total pay hours: #{crew.pay_hours}

Your daily pay is: $#{crew.daily_pay}|

print "\n1x #{crew.straight_time}, 1.5x #{crew.overtime}, 2x #{crew.golden_time}, 3x #{crew.triple_time}\n"
