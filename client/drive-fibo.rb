require 'rubygems'
require 'rest_client'
require 'active_support/core_ext'
require 'faker'
require 'pp'

url='http://fibo.stackato-xy6b.local'
url = ARGV[0]
if !url
  $stderr.puts "Usage #{$0} url (e.g. http://fibo.stackato-xyz9.local)" 
  exit 1
end
I18n.enforce_available_locales = false

iter = 100000
delay=0.001
fault_segments = 0
faults_this_time = 0
iter.times do |ix|
  begin
    n = 20 + (20 * rand).to_i
    t1 = Time.now
    res = RestClient.get("#{url}/fib/#{n}")
    t2 = Time.now
    puts "#{Time.now.strftime("%I:%M:%S")}: iter #{ix},fib(#{n}) =>  #{res}, time:#{t2 - t1}"
    #sleep delay
    #sleep delay
    faults_this_time = 0
  rescue => e
    puts "Error in iter #{ix}: #{e.message}"
    if faults_this_time == 0
      fault_segments += 1
    end
    faults_this_time += 1
    if faults_this_time == 10
      $stderr.puts "Can't recover"
      raise
    end
    raise
    $stderr.puts "******************************************* Sleeping..."
    sleep 1.0
  end
end
puts "fault_segments: #{faults_this_time}"
