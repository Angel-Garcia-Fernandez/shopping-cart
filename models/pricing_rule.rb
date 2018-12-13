# Pricing Rule classes. The Standard one (PricingRule) and
# its specialities (GetFree and BulkDiscount).
# It makes pricing calculation, from quantity and price applying
# a specific pricing rule.
class PricingRule
  attr_reader :offer, :offer_opts, :price, :quantity

  def initialize
    @price, @quantity = 0, 0
  end

  def calculate_price(price, quantity)
    @price, @quantity = price, quantity
    efective_price * efective_quantity
  end

  def efective_price
    price
  end

  def efective_quantity
    quantity
  end
end

# Accepts :from option that means how many items needed to
# get one free. 'from: 3' is like 3x2. 'from: 2' is like 2x1
class GetFree < PricingRule
  def initialize(offer_opts)
    super()
    @quantity_limit = offer_opts[:from] || 2
  end

  def efective_quantity
    free = quantity / @quantity_limit
    quantity - free
  end
end

# Also accepts :from option. Also :new_price for exact new price,
# :discount_amount for a specific reduction of the price or
# :discount_percentage for a proportional reduction in price.
class BulkDiscount < PricingRule
  def initialize(offer_opts)
    super()
    @quantity_limit = offer_opts[:from] || 2
    @new_price = offer_opts[:new_price]
  end

  def efective_price
    quantity >= @quantity_limit ? @new_price : price
  end
end
