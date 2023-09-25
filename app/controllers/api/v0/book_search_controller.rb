class Api::V0::BookSearchController < ApplicationController
  def index
    if params[:location].nil?
      render json: { error: "Please provide a location" }, status: 400
    else
      books = BooksFacade.new.get_books(params[:location])
      render json: BooksSerializer.new(books)
    end
  end
end