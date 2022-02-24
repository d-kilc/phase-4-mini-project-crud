class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        render json: Spice.all
    end

    def create
        spice = Spice.create! spices_params
        render json: spice, status: :created
    end

    def update
        spice = Spice.update! spices_params
        render json: spice, status: :updated
    end

    def destroy
        spice = Spice.find params[:id]
        spice.destroy!
        head :no_content
    end

    private

    def spices_params
        params.permit(:title,:image,:description,:notes,:rating)
    end

    def record_invalid
        render json: {error: "invalid record."}, status: :unprocessable_entity
    end

    def record_not_found
        render json: {error: "record not found."}, status: :accepted
    end
end
