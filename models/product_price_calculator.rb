# Takes a product and a pricing rule and is responsible
# for the quantity of it. Then returns the pricing calculation.
class ProductPriceCalculator
  attr_reader :pricing_rule, :product, :quantity

  def initialize(product, pricing_rule)
    @product, @pricing_rule, @quantity = product, pricing_rule, 0
  end

  def add_item
    @quantity += 1
  end

  def calculate
    @pricing_rule.calculate_price(product.price, quantity)
  end
end
