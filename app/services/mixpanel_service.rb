class MixpanelService
  def initialize(user)
    return unless ENV['MIXPANEL_TRACKING_CODE']
    @tracker = Mixpanel::Tracker.new(ENV['MIXPANEL_TRACKING_CODE'])
    @user = user
    @user_id = user&.id || SecureRandom.uuid

    @tracker.people.set(@user_id, user_properties) if user
  end

  def on_login
    @tracker&.track(@user_id, 'Login')
  end

  private

  def user_properties
    return {} unless @user

    { id: @user.id, Email: @user.email, Name: 'Random Guy' }
  end
end
