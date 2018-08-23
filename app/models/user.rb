class User < ApplicationRecord
  acts_as_google_authenticated issuer: Rails.application.config.issuer_name, lookup_token: :encrypted_password

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def mfa_authenticated?
    two_factor_authenticated
  end

  def mfa_qr_uri
    set_google_secret unless google_secret

    google_qr_uri
  end
end
