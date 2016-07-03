# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = false
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :get
  config.secret_key = 'a916e98685565a8515d86bbc0fd7248ae47810528ae10e109e538cc2aece7a9e16482c0a336a43a85e72475934e8ea1abc86c268b6481fffac42885aa1251124'
  config.mailer_sender = "maxprofkom@gmail.com"
  config.omniauth :vkontakte, '5255623', 'DnkhBPj9o0LMj9tvQT5L',
    {
      :scope => 'friends,audio,photos,email',
      :display => 'popup',
      :lang => 'en',
      :image_size => 'original'
    }
  config.omniauth :facebook, '1672069996416106', '81443f0de20f8adab7b8f75367371d72'
  config.omniauth :twitter, 'L1cBaWRJKsZwrFlMaWPexX24U', '70MyWBSsKvHri1C3IfQGS4jHuNH6GdPGOSbfDS6h1nhNT9C3rM'
end
