require_relative 'pricing_rule'

# Factory to create the PricingRule from params
class PricingRuleFactory
  def self.create(offer = nil, offer_opts = {})
    case offer
    when :get_free
      GetFree.new(offer_opts)
    when :bulk_discount
      BulkDiscount.new(offer_opts)
    when nil
      PricingRule.new
    else
      raise StandardError
              .new('PricingRuleFactory: pricing rule type doesn\'t exist')
    end
  end
end
