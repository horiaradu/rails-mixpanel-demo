class User::SessionsController < Devise::SessionsController
  def create
    super do |user|
      track_login(user)
    end
  end

  private

  def track_login(user)
    MixpanelService.new(user)&.on_login
  end
end
