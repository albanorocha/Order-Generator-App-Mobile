class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :component

  validates :user_id, :component, :body, presence: true

end
