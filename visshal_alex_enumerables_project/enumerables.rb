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

end

a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true