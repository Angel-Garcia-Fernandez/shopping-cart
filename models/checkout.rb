require_relative 'product_list'

# Checkout allows items to be scanned and
# returns the total amount to be paid.
class Checkout
  attr_reader :pricing_rules, :items

  def initialize(pricing_rules)
    @items = []
    @product_list = ProductList.new(pricing_rules)
  end

  def scan(product_code)
    @product_list.add_item(product_code)
    @items << product_code
  end

  def total
    @product_list.total
  end
end
