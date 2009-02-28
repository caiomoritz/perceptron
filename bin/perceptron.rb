#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require 'perceptron'
require 'optparse'

# defaults
options = {}
options[:max_epochs] = 5
options[:weights] = [0, 0]
options[:verbose] = true

# options
OptionParser.new do |opts|

  opts.version = '0.1'
  opts.program_name = 'RubyORPerceptron'

  opts.on("-h", "--help", "Show this message") do
    puts opts
    exit
  end

  opts.on("-v", "--version", "Show version") do
    puts opts.version
    exit
  end

  opts.on("-e INTEGER", "--maxepochs", Integer, "Maximum number of training epochs (defaults to #{options[:max_epochs]}).") do |v|
    options[:max_epochs] = v
  end

  opts.on("-a", "--weight1 INTEGER", Integer, "Value of weight 1 (defaults to #{options[:weights][0]}).") do |v|
    options[:weights][0] = v
  end

  opts.on("-b", "--weight2 INTEGER", Integer, "Value of weight 2 (defaults to #{options[:weights][1]}).") do |v|
    options[:weights][1] = v
  end

  opts.on("-q", "--quiet", "Supress normal output") do
    options[:verbose] = false
  end

end.parse!

perceptron = AI::Perceptron.new(options[:max_epochs], options[:weights])

# verbose output?
if options[:verbose]
  puts "Starting training..."
  perceptron.on_each_epoch = Proc.new do |epoch, weights|
    puts "#{epoch}) Perceptron not trained yet (#{weights.join(', ')})."
  end

  perceptron.on_trained = Proc.new do |epoch, weights|
    puts " * #{epoch}) Perceptron now trained (#{weights.join(', ')}). * "
  end
end

perceptron.train

# results
puts "Results..."
if perceptron.trained?
  puts "Perceptron successfully trained in #{perceptron.curr_epoch} epochs."
else
  puts "Perceptron couldn't be trained in #{perceptron.curr_epoch} epochs."
end
