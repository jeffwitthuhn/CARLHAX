class StaticPagesController < ApplicationController
  before_action :signed_in_user, only: [:admin]

  def home
  end
end
