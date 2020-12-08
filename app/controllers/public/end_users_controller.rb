class Public::EndUsersController < ApplicationController
	def show
	end

	def edit
		@end_user = current_end_user
		if @end_user.id != current_end_user.id
			redirect_to end_user_path(current_end_user.id)
		end
	end

	def withdraw
		@end_user = current_end_user
	end

	def update
		@end_user = current_end_user
		if @end_user.update(end_user_params)
			redirect_to root_path(current_end_user), notice:'You have updated user successfully.'
	    else
	      	render :edit
        end
	end

	def destroy
		@end_user = current_end_user
        #is_deletedカラムにフラグを立てる(defaultはfalse)
        @end_user.update(is_deleted: true)
        #ログアウトさせる
        reset_session
        redirect_to root_path
	end

	private

    def end_user_params
	    params.require(:end_user).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number)
	end
end
