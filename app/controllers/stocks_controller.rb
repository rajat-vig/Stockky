class StocksController < ApplicationController
	
	def search
		if params[:stock]
			@stock = Stock.find_by_ticker(params[:stock]) #search if stock present in instance variable otherwise fetch and store in instance variable
			@stock ||= Stock.new_from_lookup(params[:stock]) #storing result in @stock variable for optimization
		end
		
		if @stock
#			render json: @stock
			render partial: 'lookup'
		else
			render status: :not_found, nothing: true
		end
		
	end
	
end