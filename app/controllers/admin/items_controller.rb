class Admin::ItemsController < ApplicationController
	def index
		@items = Item.all
	end

	def new
		@item = Item.new
		@genres = Genre.where(is_active: 'true')
		# tureであるものを選ぶ
	end

	def show
		@item = Item.find(params[:id])
	end

	def edit
	end

	def create
		item = Item.new(item_params)
		item.save!
		redirect_to admin_items_path
	end
	def update
	end


	private
	def item_params
		params.require(:item).permit(:name, :image, :price, :introduction, :is_active, :genre_id)
	end

end
