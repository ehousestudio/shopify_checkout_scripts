# Author: Jeff Schnepple
# Note: Shopify doesn't allow you to exclude line items from a discount code
# Workaround: Create a 0% off discount code and apply to all items without the No Discount Tag

case Input.cart.discount_code
when CartDiscount::Percentage
  discount_code_string = Input.cart.discount_code.code
  if discount_code_string.include? "jeffslaborday" #check to see the % based coupon code is the one we want
	Input.cart.line_items.each do |line_item| #run through the line items in the cart
	  product = line_item.variant.product
	  apply_discount = true #default the discount to be applied
		  for tag in product.tags
		  	if tag.include? "No Discount"
		  		apply_discount = false #do not apply the discount for this product
		  	end
		  end
		  if apply_discount
		  	line_item.change_line_price(line_item.original_line_price*0.8, message: "Labor Day Discount") #change the line item price to refelct a 20% discount
		  else
		  	puts "No discount applied"
		  end
	  end
	else
		puts "Not the correct discount code"
  end
end

Output.cart = Input.cart
