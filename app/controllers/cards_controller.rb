class CardsController < ApplicationController
  before_action :all_cards, only: [:index, :create, :update, :destroy]
  before_action :set_cards, only: [:edit, :update, :destroy]
  respond_to :html, :js, :json


  # def index
  #   @cards = Card.all
  # end

  def new
    @card = Card.new
  end

  def edit
    # @card = Card.find(params[:id])
  end

  def create
    @card = Card.new(card_params)
    # respond_to do |format| 
    #   if @card.save 
    #     format.html 
    #     format.js { render 'create.js.erb' }
    #   else  
    #    format.html { render :action => "new" }  
    #    format.js
    #   end  
    # end
  end

  def update
    @card.update_attributes(card_params)
    respond_to do |format| 
      if @card.update_attributes(card_params) 
        format.html 
        format.js { render 'update.js.erb' }
      else  
       format.html { render :action => "new" }  
       format.js
      end  
    end
  end

  def destroy
    @card.destroy
  end

  private
    def all_cards
      @cards = Card.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_cards
      @card = Card.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:company, :amount, :credit_card_number, :add_credit, :remove_credit)
    end
end
