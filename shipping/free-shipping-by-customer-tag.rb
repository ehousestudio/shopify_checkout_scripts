SHIPPING_HEADER = "USPS Priority - USA Only" #additional message
SHIPPING_SUBHEADER = "FREE Subscribe & Save Member Shipping" #additional message
MINIMUM_ORDER_AMOUNT = 99 #dollars required in cart to get discount
customer = Input.cart.customer

if customer
  if customer.tags.include?("ehouse")
    Input.shipping_rates.each do |shipping_rate|
      if Input.cart.subtotal_price_was >= (Money.new(cents:100) * MINIMUM_ORDER_AMOUNT)
        shipping_rate.change_name(SHIPPING_HEADER, { message: SHIPPING_HEADER })
      end
      shipping_rate.apply_discount(shipping_rate.price, message: SHIPPING_SUBHEADER)
      break
    end
  end
end

Output.shipping_rates = Input.shipping_rates
