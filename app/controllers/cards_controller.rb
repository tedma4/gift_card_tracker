class CardsController < ApplicationController
  
  def index
    @cards = Card.all
  end

  def show
    @card = Card.find(params[:id])
  end

  def new
    @card = Card.new
  end

  def create
    @cards = Card.all
    @card = Card.create(card_params)
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @cards = Card.all
    @card = Card.find(params[:id])
    
    @card.update_attributes(card_params)
  end

  def delete
    @card = Card.find(params[:card_id])
  end

  def destroy
    @cards = Card.all
    @card = Card.find(params[:id])
    @card.destroy
  end

private
  def card_params
    params.require(:card).permit(:company, :amount, :credit_card_number, :add_credit, :remove_credit)
  end
end