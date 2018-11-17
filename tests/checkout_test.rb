# This is a test for Checkout class
#
# Developed by Ángel García Fernández

require 'test/unit'
require_relative '../models/product'
require_relative '../models/pricing_rules'
require_relative '../models/checkout'
require_relative '../models/item'

module Tests
	class CheckoutTest < Test::Unit::TestCase
		def setup
			@green_tea = Product.new( 'GR1','Green tea', 3.11 )
			@strawberry = Product.new( 'SR1','Strawberries', 5.0 )
			@coffee = Product.new( 'CF1','Coffee', 11.23 )
			@green_tea_rule = PricingRules::GetFree.new( @green_tea, 2 )
			#@strawberry_rule = PricingRules::ExactPrice.new( @strawberry, 3, 4.50 )
			@strawberry_rule = PricingRules::DropDiscount.new( @strawberry, 3, 0.50 )
			@coffee_rule = PricingRules::PercentageDiscount.new( @coffee, 3, 1/3.0 )
			@pricing_rules = [ @green_tea_rule, @strawberry_rule, @coffee_rule ]
		end

		def test_1
			co = Checkout.new( @pricing_rules )
			co.scan( Item.new( @green_tea ) )
			co.scan( Item.new( @strawberry ) )
			co.scan( Item.new( @green_tea ) )
			co.scan( Item.new( @green_tea ) )
			co.scan( Item.new( @coffee ) )
			price = co.total

			assert_equal(22.45, price )
		end

		def test_2
			co = Checkout.new( @pricing_rules)
			co.scan( Item.new( @green_tea ) )
			co.scan( Item.new( @green_tea ) )
			price = co.total

			assert_equal(3.11, price )
		end

		def test_3
			co = Checkout.new( @pricing_rules )
			co.scan( Item.new( @strawberry ) )
			co.scan( Item.new( @strawberry ) )
			co.scan( Item.new( @green_tea ) )
			co.scan( Item.new( @strawberry ) )
			price = co.total

			assert_equal(16.61, price )
		end

		def test_4
			co = Checkout.new(@pricing_rules)
			co.scan( Item.new(@green_tea) )
			co.scan( Item.new(@coffee) )
			co.scan( Item.new(@strawberry) )
			co.scan( Item.new(@coffee) )
			co.scan( Item.new(@coffee) )
			price = co.total

			assert_equal(30.57, price )
		end
	end
end