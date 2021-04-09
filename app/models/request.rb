class Request < ApplicationRecord
  belongs_to :user
#   belongs_to :user, class_name: "user", foreign_key: "user_id"
end
