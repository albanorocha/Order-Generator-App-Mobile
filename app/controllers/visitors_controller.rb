class VisitorsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @orders = policy_scope(Order.all.order('created_at DESC'))

    authorize :visitor, :index?
  end
end
