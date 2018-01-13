class BeersController <ApplicationController
  def show
    beer = Beer.find_by(beer_type: params[:beer_type])
    render file: "#{Rails.root}/public/404.html", status: 404 and return unless beer.present?

    render json: beer
  end
end
