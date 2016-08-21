class Api::V1::ItemByCategoryController < ApplicationController
  before_action :set_category, only: [:show]

  # GET /sellers
  def index
    @category = Category.all    
    render json: @category
  end

  # GET /sellers/1
  def show
    render json: select_items(@category)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def refine_item_outlook(item)
      the_item = {id: item.id, title: item.title, description: item.description, category: Category.find(item.category_id).value, 
        price: "%.2f" % item.price, seller_name: Seller.find(item.seller_id).name, seller_longitude: Seller.find(item.seller_id).longitude,
        seller_latitude: Seller.find(item.seller_id).latitude, status: Status.find(item.status_id).value, published_date: item.published_date}
    end

    def select_items(category)
      the_items = []
      avalilable_id = Status.where(value: "Available").take.id
      items = Item.where(category_id: category.id, status_id: avalilable_id)
      items.each do |i|
        the_items.push(refine_item_outlook(i))
      end
      return the_items
    end

    def is_number? string
      true if Integer(string) rescue false
    end

    def set_category
      #if passed Category Id
      if is_number?(params[:id])
        @category = Cateory.find(params[:id])
      # if passed Category Name
      else
        @category = Category.where(value: params[:id]).take
      end
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.fetch(:category, {})
    end
end
