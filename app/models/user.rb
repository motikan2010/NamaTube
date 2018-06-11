class User < ApplicationRecord

  def self.twitter_find_or_create_from_auth(auth)
    auth_type = 1
    uid = auth[:uid]
    name = auth[:info][:nickname]

    self.find_or_create_by(auth_type: auth_type, uid: uid) do |user|
      user.name = name
      user.nickname = name
    end
  end

  def self.github_create_with_omniauth(auth)
    create! do |user|
      user.name = auth['info']['nickname']
      user.uid = auth['uid']
      user.auth_type = 2
      user.nickname = auth['info']['nickname']
    end
  end

end
