class Order < ActiveRecord::Base
  after_initialize :set_default_type, :if => :new_record?

  enum order_type: [:proposta, :contra_proposta, :modelo]

  belongs_to :user
  has_many :blocks, dependent: :destroy
  has_many :components, through: :blocks
  has_many :order_images, dependent: :destroy

  accepts_nested_attributes_for :blocks, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :order_images, reject_if: :all_blank, allow_destroy: true

  def set_default_type
    self.order_type ||= :proposta
  end

  def code_and_user
    "#{code} - #{user.name unless user.nil?}"
  end
end
