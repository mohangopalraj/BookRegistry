class BooksController < ApplicationController
	helper_method :sort_column, :sort_direction

	# def index
	# 	@books = Book.all.order("#{sort_column} #{sort_direction}")
	# 	if params[:search].present? && !params[:search].blank?
	# 		@books = @books.where('name LIKE :search or author LIKE :search or isbn LIKE :search or price LIKE :search or category LIKE :search or status LIKE :search',search: "%#{params[:search]}%")
	# 	end
	# end

	def new
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)
    	if @book.save
      		redirect_to :action => 'index'
    	else
      		render :status=>"Not Updated"
    	end
	end

	def edit
		@book = Book.find_by_id(params[:id])
	end

	def update
		@book = Book.find_by_id(params[:id])
		if @book.update_attributes(book_params)
      		redirect_to :action => 'index'
    	else
      		render :action => "edit"
    	end
	end

	def destroy
		@book_details = Book.find_by_id(params[:id])
		@book_details.destroy
		redirect_to :action => 'index'
	end

	def update_status
		@book = Book.find_by_id(params[:id])
		if @book.update_attribute("status",params[:status])
			render :json => @book
		else
			render :status=>"Not Updated"
		end
	end

	private
	def book_params
		params.require(:book).permit!
	end

	def sortable_columns
    	["name", "author","isbn","category","status","price"]
  	end

	def sort_column
	   sortable_columns.include?(params[:column]) ? params[:column] : "name"
	end

	def sort_direction
	    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end

end



