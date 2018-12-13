require 'ostruct'
require_relative 'pricing_rule_factory'

# Collection products and pricing rules.
class PricingRules
  attr_reader :products

  def initialize
    @products = {}
  end

  def add_pricing(product, offer = nil, offer_opts = {})
    @products[product.code] =
      OpenStruct.new(product: product,
                     pricing_rule: PricingRuleFactory.create(offer, offer_opts))
  end

  def get_pricing(product_code)
    @products[product_code]
  end
end
