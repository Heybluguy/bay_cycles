class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_accessory(accessory)
    @contents[accessory.to_s] += 1
  end

  def total_value
    values = []
    @contents.each_pair do |accessory, quantity|
      values << Accessory.find(accessory).price * quantity
    end
    values.sum
  end
end
