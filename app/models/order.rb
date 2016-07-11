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

  def dup_order
    order = self

    new_order = order.dup
    new_order.code = "DUP-#{order.id}"
    new_order.enable = false
    new_order.approved = false
    new_order.user = nil

    order.blocks.each do |block|
      new_block = block.dup

      block.components.each do |component|
        new_component = component.dup

        component.items.each do |item|
          new_item = item.dup
          new_component.items << new_item
        end

        new_block.components << new_component
      end

      new_order.blocks << new_block
    end


    new_order
  end
end
