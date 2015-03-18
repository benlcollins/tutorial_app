class PagesController < ApplicationController

	before_action :get_favorites

	def get_favorites
		@favorites = Favorite.all
	end

	def about
		
	end

end