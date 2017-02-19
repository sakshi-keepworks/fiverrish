class ServicesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_service, only: [:show, :edit, :update]

  def index
    @services = current_user.services
  end

  def show
  end

  def new
    @service = current_user.services.build
  end

  def create
    @service = current_user.services.build(service_params)
    if @service.save
      redirect_to @service
    else
      render :new
    end
  end

  def order
    @services = Service.where.not(user: current_user)
  end

  def edit
  end

  def update
    # TODO: Save the updated service. Redirect to an appropriate page if save fails.
  end

  private

  def service_params
    params.require(:service).permit(:title,
                                    :description,
                                    :price,
                                    :requirements,
                                    :image)
  end

  def set_service
    @service = Service.find(params[:id])
  end
end
