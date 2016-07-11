class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:vkontakte, :facebook, :twitter]
  # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  has_attached_file :avatar,
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    :dropbox_options => {:path => proc {|style| "files/#{id}/#{avatar.original_filename}"}},styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  has_many :questions, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  validates :email, uniqueness: true
  validates :email, presence: true
  acts_as_voter
  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid). first_or_initialize do |user|
        user.provider = auth.provider
        user.name = auth.info.name
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.skip_confirmation!
        user.save
      end
  end
end
