class CatRentalRequestsController < ApplicationController
    def create
        @rental_request = CatRentalRequest.new(cat_rental_request_params)
        if @rental_request.save
            redirect_to cat_url(@rental_request.cat)
        else
            render :new
        end
    end

    def new
        @rental_request = CatRentalRequest.new
    end

    private

    def cat_rental_request_params
        params.require(:cat_rental_request).permit(:cat_id, :end_date, :start_date, :status)
    end
end