class Order < ApplicationRecord
	belongs_to :end_user
	has_many :order_details

	validates :address_option, acceptance: true, on: :create

	enum payment_method: { クレジットカード: 0, 銀行振込: 1 }
	enum status: [:入金待ち, :入金確認, :製作中, :発送準備中, :発送済み] #下のように書くと数字の指定が不要

end
