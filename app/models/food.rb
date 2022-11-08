class Food < ApplicationRecord

  has_many_attached :images
  has_many :favorites, dependent: :destroy
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

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @food = Food.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @food = Food.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @food = Food.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @food = Food.where("title LIKE?","%#{word}%")
    else
      @food = Food.all
    end
  end


end
