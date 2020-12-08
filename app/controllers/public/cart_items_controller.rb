class Public::CartItemsController < ApplicationController
	def index
		@carts = current_end_user.cart_items
	end


	def create
		@cart = current_end_user.cart_items.new(cart_params)
		@carts = current_end_user.cart_items.all
		@carts.each do |cart|
			if  @cart.item_id == cart.item_id
			    new_amount = cart.amount + @cart.amount
    	   		cart.update_attribute(:amount, new_amount)
    	   		@cart.delete
			end
		end
		# @cart_item.public_id = current_public.id #←9行目でまとめた
		@cart.save
		@carts = current_end_user.cart_items
		redirect_to cart_items_path
	end


	def update
		@cart = CartItem.find(params[:id])
		@cart.update(cart_params)
		redirect_to cart_items_path
	end

	def destroy
		carts = CartItem.find(params[:id])
		carts.destroy
		redirect_to cart_items_path
	end

	def destroy_all
		@carts = current_end_user.cart_items
		@carts.each do |cart|
			cart.destroy
		end
		redirect_to cart_items_path
	end

	private
	def cart_params
		params.require(:cart_item).permit(:amount, :item_id, :end_user_id)
	end
end
