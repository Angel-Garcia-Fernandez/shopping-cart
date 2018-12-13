# Class that represents a product and its propierties.
# I have thought a lot about leaving the price in product or
# move it to pricing rule, and finally I have decided that
# has more sense in pricing_rule. (I could leave something like
# default_price, but not by now)
class Product
  attr_reader :code, :name, :price

  def initialize(code, name, price)
    @code, @name, @price = code, name, price
  end

  def ==(other)
    code == other.code
  end
end
