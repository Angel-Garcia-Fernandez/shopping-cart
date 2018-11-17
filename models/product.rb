class Product
	attr_reader :code, :name, :price

	def initialize code, name, price
		@code, @name, @price = code, name, price
	end

	def == another_product 
		self.code == another_product.code
	end
end