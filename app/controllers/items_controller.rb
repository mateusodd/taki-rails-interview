class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_businesses, only: [:new, :create, :edit, :update]
  
  def index
    # List all of the Items that are owned by the logged in User's Business
    if current_business.present?
      @items = current_business.items
    else
    # If business not yet created, redirect to create a new business
      redirect_to new_business_path, notice: "Please create a business."
    end
  end

  def show
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to items_path, notice: 'Item was successfully created'
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to items_path, notice: 'Item was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to items_path, notice: 'Item was successfully removed'
    end
  end

  private

    def set_item
      @item = Item.find(params[:id])
    end

    def set_businesses
      @businesses = Business.where(user_id: current_user.id)
    end

    def item_params
      params.require(:item).permit(:name, :price, :business_id)
    end
end
