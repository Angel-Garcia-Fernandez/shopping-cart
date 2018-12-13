require_relative 'product_price_calculator'

# Product list of the checkout.
class ProductList
  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @product_list = {}
  end

  def add_item(product_code)
    if @product_list[product_code].nil?
      pricing = @pricing_rules.get_pricing(product_code)
      if !pricing.nil?
        @product_list[product_code] =
          ProductPriceCalculator.new(pricing.product, pricing.pricing_rule)
      else
        raise StandardError.new('Checkout: product without pricing policy')
      end
    end
    @product_list[product_code].add_item
  end

  def total
    @product_list.values.map(&:calculate).sum.round(2)
  end
end
