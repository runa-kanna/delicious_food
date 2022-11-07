class Food < ApplicationRecord

  has_many_attached :images
  has_many :comments, dependent: :destroy
  belongs_to :user, optional: true

  validates :title, presence: true
  validates :body, presence: true
  validate :image_length

  def get_image
    unless images.attached?
      file_path = Rails.root.join('app/assets/images/noimage.jpg')
      images.attach(io: File.open(file_path),filename:'default-image.jpg',content_type:'image/jpeg')
    end
    images
  end


end
