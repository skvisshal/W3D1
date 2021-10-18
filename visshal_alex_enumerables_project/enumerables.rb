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
end

a = [ "a", "b", "c", "d" ]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]
p a.my_rotate         #=> ["b", "c", "d", "a"]
