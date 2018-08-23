module UserGoogleAuthentication
  extend ActiveSupport::Concern

  included do
    acts_as_google_authenticated issuer: Rails.application.config.issuer_name,
                                 lookup_token: :encrypted_password

    def mfa_authenticated?
      two_factor_authenticated
    end

    def mfa_qr_uri
      set_google_secret unless google_secret

      google_qr_uri
    end
  end
end
