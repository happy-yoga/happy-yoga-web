class NotRegisteredError < StandardError ; end
class NoAdminRoleError < StandardError ; end
class UnallowedDummyUserAccessError < StandardError ; end

class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first.tap do |user|
      user.email = auth.info.email
      user.uid = auth.uid
      user.provider = auth.provider
      user.avatar_url = auth.info.image
      user.username = auth.info.name
      user.oauth_token = auth.credentials.token
      # user.save!
    end

    Rails.logger.debug user.inspect

    raise NotRegisteredError.new('the given user is not in the database') unless user
    raise NoAdminRoleError.new('You don\'t have the appropriate rights to access these resources') unless user.is_admin?

    return user
  end

  def self.dummy_user
    unless Rails.env.production?
      User.new.tap do |user|
        user.id = 1
        user.email = 'dummy@user.de'
        user.uid = 12345
        user.provider = 'godhub'
        user.avatar_url = 'https://fthmb.tqn.com/tVtfXU4sqXsVY2_4CMsSX9XbpeA=/768x0/filters:no_upscale()/about/spongebob_wide-56a00f0a5f9b58eba4aeb6f2.jpg'
        user.username = 'Spunchy'
        user.admin = true
      end
    else
      raise UnallowedDummyUserAccessError.new('dummy user is not allowed in production')
    end
  end
end
