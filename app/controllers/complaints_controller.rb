class ComplaintsController < ApplicationController
  def new
    @complaint = Complaint.new
  end

  def create
    @complaint = Complaint.new(params[:complaint])
    if @complaint.save
      # @complaint.store_to_advanced_backend
      redirect_to action: :confirmation
    else
      render 'new'
    end
  end

  def confirmation
  end
end