# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  config.mailer_sender = 'mailer@example.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :get

  #Add your ID and secret here
  #ID first, secret second
  config.omniauth :vkontakte, '5255623', 'DnkhBPj9o0LMj9tvQT5L',
    {
      :scope => 'friends,audio,photos,email',
      :display => 'popup',
      :lang => 'en',
      :image_size => 'original'
    }
  config.omniauth :facebook, '1672069996416106', '81443f0de20f8adab7b8f75367371d72'
end
