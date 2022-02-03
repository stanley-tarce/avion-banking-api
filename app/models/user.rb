class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:omniauthable, :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(token)
    User.find_or_create_by(email: token[:info]['email']) do |user|
      user.image = token[:info]['image']
    end
  end
end
