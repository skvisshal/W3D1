class Array

    def my_each(&blk)
        i = 0
        while i < self.length
            blk.call(self[i])
            i+=1
        end
        self
    end

    def my_select(&blk)
        result = []
        self.my_each do |ele|
            result << ele if blk.call(ele)
        end 
        result
    end

    def my_reject(&blk)
        result = []
        self.my_each do |ele|
            result << ele if !blk.call(ele)
        end 
        result
    end

    def my_any?(&blk)
        self.my_each do |ele|
            return true if blk.call(ele)
        end
        false
    end

    def my_all?(&blk)
        self.my_each do |ele|
            return false if !blk.call(ele)
        end
        true
    end

    def my_flatten
        result = []
        # result << self if !self.is_a?(Array)
        (0...self.length).each do |i|
            if self[i].is_a?(Array)
                result +=  self[i].my_flatten 
            else
                result << self[i]
            end
        end
        result
    end

    def my_zip(*args)
        result = Array.new(self.length){Array.new}
        self.each_with_index do |ele, i|
            result[i] << ele
            args.each do |arg|
                result[i] << arg[i]
            end
        end
        result
    end

    def my_rotate(rotator = 1)
        result = self.dup
        if rotator >= 0
            rotator.times do 
                result << (result.shift)
            end
        else
            (-rotator).times do
                result.unshift(result.pop)
            end
        end
        result
    end

    def my_join(separator = "")
        result = ""
        (0...self.length - 1).each do |index|
            result += (self[index] + separator)
        end
        result += self[-1]
    end

    def my_reverse
        result = []
        self.each do |ele|
            result.unshift(ele)
        end
        result
    end
end

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
