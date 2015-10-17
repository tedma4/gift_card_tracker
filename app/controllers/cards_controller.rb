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
    if @card.add_credit
      flash[:success] = "You successfully added credit to the card"
      redirect_to root_path
    end

    if @card.remove_credit
      flash[:error] = "Sorry, You do not have enough credit for that"
    end
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
    params.require(:card).permit(:company, :amount, :cc_num, :add_credit, :remove_credit)
  end
end