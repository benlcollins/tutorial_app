class LinksController < ApplicationController

	before_action :link_find, except: [:index, :new, :create]
	before_action :favorites_find, only: [:index]
	before_action :get_favorites
	before_action :authenticate_user!, except: [:index, :show]

	def get_favorites
		@favorites = Favorite.all
	end

	def index
		if params[:search]
			# put search results action here
			@links = Link.where("title = ?", params[:search])
			# Client.where("orders_count = ?", params[:orders])
		else
			@links = Link.all.order("created_at").reverse
		end
		@grouped_links = @links.group_by {|link| link.created_at.to_date}
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
		# grab = Blockspring.runParsed("screenshot-webpage", { "url" => "http://www.google.com", "width" => 300 }).params
		# open(grab["screenshot"]).read
		# response.addFileOutput("screenshot", "my_screenshot.png")
		# @response = response.end()

		@link_submitted_by = Link.find(params[:id]).user_id
		# binding.pry
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