class Photo < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  acts_as_votable
  include ImageUploader[:image]

  def self.search(search)
    where("caption LIKE ?", "%#{search}%")
  end
end
