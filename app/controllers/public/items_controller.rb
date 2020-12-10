class Public::ItemsController < ApplicationController
	def index
		@genres = Genre.all
		@items = Item.all
	end

	def show
		@item = Item.find(params[:id])
		@cart_item = CartItem.new
	end

	def search
		if params[:name].present?
	    	@search = Item.where('name LIKE ?', "%#{params[:name]}%")
	  		# モデルクラス.where("列名 LIKE ?", "%値%")  # 値(文字列)を含む
			# モデルクラス.where("列名 LIKE ?", "値_")   # 値(文字列)と末尾の1文字
		else
			@search = Item.none
	    end
	    @genres = Genre.all
		@items = Item.all
	    render :index
	end

end
