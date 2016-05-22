class Component < ActiveRecord::Base
  belongs_to :block

  has_many :items, dependent: :destroy
  has_many :messages, dependent: :destroy

  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
end
