require 'test/unit'
require_relative '../models/product'
require_relative '../models/pricing_rules'
require_relative '../models/checkout'

# This are the challenge tests
module Tests
  # Testing Checkout
  class CheckoutTest < Test::Unit::TestCase
    def setup
      @voucher = Product.new('VOUCHER', 'Cabify Voucher', 5.00)
      @tshirt = Product.new('TSHIRT', 'cabify T-Shirt', 20.00)
      @mug = Product.new('MUG', 'Cabify Coffee Mug', 7.50)

      @pricing_rules = PricingRules.new
      @pricing_rules.add_pricing(@voucher,
                                 :get_free, from: 2)
      @pricing_rules.add_pricing(@tshirt,
                                 :bulk_discount, from: 3, new_price: 19.00)
      @pricing_rules.add_pricing(@mug)
    end

    def test_1
      co = Checkout.new(@pricing_rules)
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      co.scan('MUG')
      price = co.total

      assert_equal(32.5, price)
      show_results(co.items, price)
    end

    def test_2
      co = Checkout.new(@pricing_rules)
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      co.scan('VOUCHER')
      price = co.total

      assert_equal(25.0, price)
      show_results(co.items, price)
    end

    def test_3
      co = Checkout.new(@pricing_rules)
      co.scan('TSHIRT')
      co.scan('TSHIRT')
      co.scan('TSHIRT')
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      price = co.total

      assert_equal(81.0, price)
      show_results(co.items, price)
    end

    def test_4
      co = Checkout.new(@pricing_rules)
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      co.scan('VOUCHER')
      co.scan('VOUCHER')
      co.scan('MUG')
      co.scan('TSHIRT')
      co.scan('TSHIRT')
      price = co.total

      assert_equal(74.50, price)
      show_results(co.items, price)
    end

    private

    def show_results(items, total)
      puts "Items: #{items.join(', ')}"
      puts "Total: #{format('%.2f', total)}€"
    end
  end
end
