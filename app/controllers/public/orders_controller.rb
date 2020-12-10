class Public::OrdersController < ApplicationController
	def new
		@order = Order.new
		@end_user = current_end_user
		@addresses = @end_user.addresses
	end

	def show
		@order = Order.find(params[:id])
		@order_details = @order.order_details
	end

	def index
		@end_user = current_end_user
		@orders = @end_user.orders
	end

	def comfirm
		@end_user = current_end_user
		@carts = current_end_user.cart_items
		@order = Order.new(order_params)
		@order.status = "入金待ち"
		@sum = 0
		@carts.each do |cart|
			@sum += cart.item.price * cart.amount
		end
		@order.total_payment = @sum

		if  params[:order][:address_option] == "0" #ご自身の住所
			@order.name = @end_user.last_name + @end_user.first_name
			@order.postal_code = @end_user.postal_code
			@order.address = @end_user.address
		elsif params[:order][:address_option] == "1" #登録済み住所から選択
			address = Address.find(params[:order][:address_id])
			@order.name = address.name
			@order.postal_code = address.postal_code
			@order.address = address.address
		elsif params[:order][:address_option] == "2" #新規住所
		end


	end

	def complete
	end

	def create
		order = Order.new(order_params)


		order.shipping_cost = 800

		carts = current_end_user.cart_items
		sum = 0
		carts.each do |cart|
			sum += cart.item.price * cart.amount
		end
		order.total_payment = sum

		carts = current_end_user.cart_items
		order.end_user_id = current_end_user.id
		order.status = "入金待ち"
		order.save


		carts.each do |cart|
			order_detail = OrderDetail.new
			order_detail.price = cart.item.price
			order_detail.amount = cart.amount
			order_detail.making_status = "製作待ち"
			order_detail.order_id = order.id
			order_detail.item_id = cart.item.id

			order_detail.save
		end
		carts = current_end_user.cart_items
		carts.each do |cart|
			cart.destroy
		end

		redirect_to orders_thanks_path

	end

	def update
		order = Order.find(params[:id])
		order.update
		if order.status == "入金確認"
			order.order_details.each do |order_detail|
				order_detail.making_status = "製作待ち"
				order_detail.update(order_detail_params)
			end
		end
		redirect_to request.referer
	end


	private
	def order_params
		params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment)
	end
	def order_detail_params
		params.require(:order_detail).permit(:price, :amount, :making_status)
	end
end
