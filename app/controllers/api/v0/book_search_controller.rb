class Api::V0::BookSearchController < ApplicationController
  def index
    if params[:location].blank?
      render json: { error: "Location can't be blank" }, status: 400
    elsif params[:quantity].to_i < 1
      render json: { error: "Please provide a quantity greater than 0" }, status: 400
    else
      books = BooksFacade.new.get_books(params[:location], params[:quantity])
      render json: BooksSerializer.new(books)
    end
  end
end
