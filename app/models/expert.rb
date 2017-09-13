class Expert < ApplicationRecord
  has_many :expertises
  def self.from_omniauth(auth)
  where(email: auth.info.email).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    user.email = auth.info.email
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.save!
  end
end
end
