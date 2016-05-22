class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  validates :password, confirmation: true,
    unless: Proc.new { |a| a.password.blank? }

  validates :name, :email, :name, :username, :company, :role, presence: true

  validates :password, presence: true, on: :create
  validates :password, presence: true, on: :update, allow_blank: true

  # TODO; Se o usuário for deletado deixar o order sem usuário
  has_many :orders, dependent: :destroy
  has_many :messages, dependent: :destroy

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
end
