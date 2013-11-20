class Post < ActiveRecord::Base
  validates :title, :description, presence: true, length: {minimum: 3}
end
