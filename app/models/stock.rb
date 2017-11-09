class Stock < ActiveRecord::Base

  has_many :user_stocks
  has_many :users, through: :user_stocks
  
  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
  
  def self.new_from_lookup(ticker_symbol)
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    return nil unless looked_up_stock.name #if searched is performed and looked_up_stock.name doesn't exist, then return nil
    
    new_stock = new(ticker: looked_up_stock.t, name: looked_up_stock.name)
    new_stock.last_price = new_stock.price
    new_stock
  end
  
  def price
    closing_price = StockQuote::Stock.quote(ticker).l
    return "#{closing_price}" if closing_price
    
    opening_price = StockQuote::Stock.quote(ticker).op
    return "#{opening_price} (Opening)" if opening_price
    
    "Unavailable"
  end
  
end