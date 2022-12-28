array = [100, 200, 100, 900, 300, 100]
p array.each_index.select { |index| array[index] == 100 }