class OrderImage < ActiveRecord::Base
  belongs_to :order
  mount_uploader :mockup, MockupUploader
end
