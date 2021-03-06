class ItemsController < ApplicationController
  before_action :logged_in_user , except: [:show]
  before_action :set_item, only: [:show]

  def new
    if params[:q]
      @res = Amazon::Ecs.item_search(params[:q] , 
                                  :search_index => 'All' , 
                                  :response_group => 'Medium' , 
                                  :country => 'jp')
      @amazon_items = @res.items
    end
  end

  def show
    @haves = @item.have_users
    @wants = @item.want_users
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
end
