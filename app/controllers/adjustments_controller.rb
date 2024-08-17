class AdjustmentsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @adjustments = Adjustment.order(:created_at)
      if @adjustments.empty?
        flash[:alert] = "No adjustments found."
      end
    end
  end
  