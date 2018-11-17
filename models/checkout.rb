class Checkout
	attr_reader :items, :pricint_rules, :product_list

	def initialize pricing_rules
		@pricing_rules = check_pricing_rules( pricing_rules )
		@items = []
		@product_list = {}
	end

	def scan item
		@items << item
		update_product_list( item )
	end

	def total
		@product_list.inject( 0 ) do |total,product_quantity_pair|
			product = product_quantity_pair.first
			quantity = product_quantity_pair.last
			
			total += !@pricing_rules[ product ].nil? ?
				@pricing_rules[ product ].perform( product, quantity ) :
				product.price * quantity
		end.round(2)
	end

	private
	def update_product_list item
		if @product_list.has_key? item.product
			@product_list[ item.product ] += 1
		else
			@product_list[ item.product ] = 1
		end
	end

	def check_pricing_rules pricing_rules
		{}.tap do |hash|
			pricing_rules.group_by( &:product ).each do |product, rules_for_product|
				hash[ product ] = rules_for_product.last
			end
		end
	end
end
