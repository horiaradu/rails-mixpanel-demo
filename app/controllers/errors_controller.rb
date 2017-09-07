class ErrorsController < ApplicationController
  include Gaffe::Errors

  # Make sure anonymous users can see the page
  skip_before_action :authenticate_user!

  # Override 'error' layout
  # layout 'application'

  # Render the correct template based on the exception "standard" code.
  # Eg. For a 404 error, the `errors/not_found` template will be rendered.
  def show
    MixpanelService.new(current_user).on_error(json_error, @status_code, request.request_id)
    respond_to do |format|
      format.html { render "errors/#{@rescue_response}", status: @status_code, layout: 'application' }
      format.json { render json: json_error, status: @status_code }
    end
  end

  private

  def json_error
    output = { error: @rescue_response }
    if Rails.env.development? || Rails.env.test?
      output[:exception] = @exception.inspect
      output[:backtrace] = @exception.backtrace
    end
    output
  end
end
