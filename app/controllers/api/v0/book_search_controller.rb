class Api::V0::BookSearchController < ApplicationController
  def index
    if params[:location].blank? || !valid_location?(params[:location])
      render json: { error: "Invalid location" }, status: 400
    elsif params[:quantity].to_i < 1
      render json: { error: "Please provide a quantity greater than 0" }, status: 400
    else
      books = BooksFacade.new.get_books(params[:location], params[:quantity])
      render json: BooksSerializer.new(books)
    end
  end

  private

  def valid_location?(location)
    location.split(",").count == 2
  end
end
