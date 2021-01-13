class Api::V1::Admin::BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_admin!

  def require_parameters(parameters:)
    byebug
    parameters.each do |param|
      params.require(param)
    end
  end
end
