class LinksController < ApplicationController

	before_action :link_find, except: [:index, :new, :create]
	before_action :favorites_find, only: [:index]
	before_action :get_favorites
	before_action :authenticate_user!, except: [:index, :show]

	def get_favorites
		@favorites = Favorite.all
	end

	def index
		@days = Link.all.map do |m|
			m.created_at.to_date
		end.uniq.sort.reverse

		@today = Time.new.to_date

		# binding.pry
		if params[:search]
			# put search results action here
			# binding.pry
			@links = Link.where("title = ?", params[:search])

			# Client.where("orders_count = ?", params[:orders])
		else
			@links = Link.all.order("created_at").reverse
		end
	end

	def new
		@link = Link.new
	end

	def create
		@link = Link.new(strong_upload_params)
		@link.user_id = current_user[:id]
		if @link.save
			flash[:success] = "Tutorial successfully uploaded"
			redirect_to links_path
		else
			flash[:alert] = "Tutorial not saved"
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
		if @link.update(strong_upload_params)
			flash[:success] = "Tutorial successfully updated"
			redirect_to link_path
		else
			flash[:alert] = "Tutorial not updated"
			render :edit
		end
	end

	def destroy
		@link.destroy
		flash[:alert] = "Tutorial link destroyed"
		redirect_to links_path
	end



	private

	def strong_upload_params
		params.require(:link).permit(:title, :link_url, :synopsis, :year)
	end

	def link_find
		@link = Link.find(params[:id])
	end

	def favorites_find
		@favorites = Favorite.all
	end

	# def search_param
	# 	@search = "%" + params[:search] + "%"
	# end

end