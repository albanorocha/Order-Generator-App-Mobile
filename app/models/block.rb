class Block < ActiveRecord::Base
  belongs_to :order

  has_many :components, dependent: :destroy

  accepts_nested_attributes_for :components, reject_if: :all_blank, allow_destroy: true
end
