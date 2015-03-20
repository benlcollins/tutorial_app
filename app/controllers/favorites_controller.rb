class FavoritesController < ApplicationController

	before_action :authenticate_user!

	def index
		@favorites = Favorite.where(:user_id => current_user[:id]).sort.reverse
	end

	def create
		# binding.pry
		favorite_params = params.require(:favorite).permit(:link_id, :title)
		@favorite = Favorite.new(favorite_params)
		@favorite.user_id = current_user[:id]
		@favorite.save
		redirect_to links_path
	end

	def destroy
		# binding.pry
		@favorite = Favorite.find(params[:id])
		@favorite.destroy
		redirect_to favorites_path
	end

end