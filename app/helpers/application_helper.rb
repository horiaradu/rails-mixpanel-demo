module ApplicationHelper
  def mixpanel_tracking_code
    ENV['MIXPANEL_TRACKING_CODE']
  end
end
