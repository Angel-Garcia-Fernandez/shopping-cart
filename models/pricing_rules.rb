module PricingRules
	class PricingRule
		attr_reader :product, :quantity_limit, :discount_number

		def initialize product, quantity_limit = nil, discount_number = nil
			@product, @quantity_limit, @discount_number = product, quantity_limit, discount_number
		end

		def perform product, quantity
			product.price * quantity
		end

		def rule_type
			self.class.to_s.to_sym
		end
	end

	class GetFree < PricingRule
		def initialize product, quantity_limit = 2
			super( product, quantity_limit )
		end

		def perform product, quantity
			free = quantity/quantity_limit
			( quantity - free ) * product.price
		end
	end

	class ExactPrice < PricingRule
		def initialize product, quantity_limit, discount_number
			super( product, quantity_limit, discount_number )
		end

		def perform product, quantity
			quantity * ( quantity >= quantity_limit ? discount_number : product.price ) 
		end
	end

	class DropDiscount < PricingRule
		def initialize product, quantity_limit, discount_number
			super( product, quantity_limit, discount_number )
		end

		def perform product, quantity
			quantity * ( product.price - ( quantity >= quantity_limit ? discount_number : 0 ) )
		end
	end

	class PercentageDiscount < PricingRule
		def initialize product, quantity_limit, discount_number
			super( product, quantity_limit, discount_number )
		end

		def perform product, quantity
			quantity * ( product.price * ( 1 - (quantity >= quantity_limit ? discount_number : 0 ) ) )
		end
	end
end