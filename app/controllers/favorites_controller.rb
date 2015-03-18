class FavoritesController < ApplicationController

	def index
		@favorites = Favorite.all.sort.reverse
	end

	def create
		# binding.pry
		favorite_params = params.require(:favorite).permit(:link_id, :title)
		@favorite = Favorite.create(favorite_params)
		redirect_to links_path
	end

	def destroy
		# binding.pry
		@favorite = Favorite.find(params[:id])
		@favorite.destroy
		redirect_to links_path
	end

end