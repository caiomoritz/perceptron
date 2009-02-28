module AI

  class Perceptron

    attr_reader :curr_epoch, :weights
    attr_accessor :on_each_epoch, :on_trained

    def initialize(epochs, weights)
      @max_epochs = epochs
      @weights = weights
      @curr_epoch = 0
      @numbers = []
      @numbers << NetworkNumber.new([0, 0], 0)
      @numbers << NetworkNumber.new([0, 1], 1)
      @numbers << NetworkNumber.new([1, 0], 1)
      @numbers << NetworkNumber.new([1, 1], 1)
    end

    def train
      while @curr_epoch < @max_epochs && (not trained?)
        @curr_epoch += 1
        @on_each_epoch.call(@curr_epoch, @weights) if @on_each_epoch.respond_to?(:call)
        @numbers.each do |number|
          net = Perceptron.net(@weights, number)
          y = Perceptron.threshold(net)
          sign = 0
          if y < number.y
            sign = 1
          elsif y > number.y
            sign = -1
          else
            next
          end
          @weights.length.times do |i|
            @weights[i] += number.pattern[i] * sign
          end
        end
      end
      @on_trained.call(@curr_epoch, @weights) if trained? && @on_each_epoch.respond_to?(:call)
    end

    def trained?
      @numbers.each do |number|
        net = Perceptron.net(@weights, number)
        y = Perceptron.threshold(net)
        return false if y != number.y
      end
      true
    end

    def Perceptron.threshold(num)
      (num >= 1) ? 1 : 0
    end

    def Perceptron.net(weights, number)
      sum = 0
      weights.length.times do |i|
        sum += weights[i] * number.pattern[i]
      end
      sum
    end

    def run
      return unless trained?
    end

  end

  class NetworkNumber

    attr_accessor :pattern
    attr_reader :y

    def initialize(pattern, y)
      @pattern = pattern
      @y = y
    end

  end

end
