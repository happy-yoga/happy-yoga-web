class NotRegisteredError extend Error ; end
class NoAdminRoleError extend Error ; end

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

    raise new NotRegisteredError('the given user is not in the database') unless user
    raise new NoAdminRoleError('You don\'t have the appropriate rights to access these resources') unless user.is_admin?

    return user
  end

  # can only be set by accessing the DB with a client directly
  def is_admin?
    self.admin
  end
end
