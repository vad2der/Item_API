
class Api::V1::SellersController < ApplicationController
  before_action :set_seller, only: [:show]

  # GET /sellers
  def index
    @sellers = Seller.all    
    render json: @sellers
  end

  # GET /sellers/1
  def show
    render json: select_items(@seller)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def refine_item_outlook(item)
      the_item = {id: item.id, title: item.title, description: item.description, category: Category.find(item.category_id).value, 
        price: "%.2f" % item.price, seller_name: Seller.find(item.seller_id).name, seller_longitude: Seller.find(item.seller_id).longitude,
        seller_latitude: Seller.find(item.seller_id).latitude, status: Status.find(item.status_id).value, published_date: item.published_date}
    end

    def select_items(seller)
      the_items = []
      sold_id = Status.where(value: "Sold").take.id
      items = Item.where(seller_id: seller.id, status_id: sold_id)
      items.each do |i|
        the_items.push(refine_item_outlook(i))
      end
      return the_items
    end

    def is_number? string
      true if Integer(string) rescue false
    end

    def set_seller
      #if passed Seller Id
      if is_number?(params[:id])
        @seller = Seller.find(params[:id])
      # if passed Seller Name
      else
        @seller = Seller.where(name: params[:id]).take
      end
    end

    # Only allow a trusted parameter "white list" through.
    def seller_params
      params.fetch(:seller, {})
    end
end