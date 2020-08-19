class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :search]
  
  def index
    @items = Item.limit(3).order('created_at DESC')
    # 画像は田中さんがマージしてから
    # @ladies_items = Item.where(category: 2).includes(:images).order("created_at DESC").limit(5)
    # ピックアップカテゴリー用
  end
  

  def show
  end
  
  def new
    @item = Item.new
  end

  def search
    @search_items = Item.search(params[:key])
  end


  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end
