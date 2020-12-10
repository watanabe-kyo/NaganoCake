class Admin::OrderDetailsController < ApplicationController
	def update
		order = Order.find_by(id: params[:order_id])
		order_detail = OrderDetail.find_by(order_id: order.id,id: params[:id])
		order = order_detail.order
		order_details = order.order_details
		order_detail.update(order_detail_params)

		if order_detail.making_status == "製作中"
			order.update(status: "製作中")
			#コントローラーで入れた情報はストロングパラメータに入らない
		end
		if order_details.where(making_status: "製作完了").count == order_details.count
			order.update(status: "発送準備中")
		end
		redirect_to admin_order_path(order)
	end

	private

	def order_detail_params
		params.require(:order_detail).permit(:making_status)
	end

end
