class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show]

  # GET /items
  def index
    @items = Item.all
    the_items = []
    @items.each do |i|
      the_items.push(refine_item_outlook(i))
    end
    render json: the_items
  end

  # GET /items/1
  def show
    render json: refine_item_outlook(@item)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def refine_item_outlook(item)
      the_item = {id: item.id, title: item.title, description: item.description, category: Category.find(item.category_id).value, 
        price: "%.2f" % item.price, seller_name: Seller.find(item.seller_id).name, seller_longitude: Seller.find(item.seller_id).longitude,
        seller_latitude: Seller.find(item.seller_id).latitude, status: Status.find(item.status_id).value, published_date: item.published_date}
    end

    def is_number? string
      true if Integer(string) rescue false
    end

    def set_item
      #if passed Item Id
      if is_number?(params[:id])
        @item = Item.find(params[:id])
      # if passed Item Title
      else
        @item = Item.where(title: params[:id]).take
      end
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:title, :description, :category_id, :price, :seller_id, :status_id, :published_date)
    end
end
  