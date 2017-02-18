class OrdersController < ApplicationController
  before_action :set_service, only: [:create]
  before_action :authenticate_user!

  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      redirect_to @order
    else
      render :new
    end
  end

  def show
    redirect_to user_orders_path
  end

  def order
    @services = Service.where.not(user: current_user)
  end

  def user_orders
    @orders = current_user.orders
  end

  private

  def order_params
    params.require(:order).permit(:service_id,
                                  :price,
                                  :quantity,
                                  :total_price)
  end

  def set_service
    @service = Service.find(params[:service_id])
  end
end
