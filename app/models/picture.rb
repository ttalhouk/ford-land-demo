class Picture < ApplicationRecord
  belongs_to :imagable, polymorphic: true, optional: true

  has_attached_file :image,
    styles: { large: '600x600', medium: "300x300>", thumb: "150x150#" }, :default_url => "/assets/images/:style/desk.jpg"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
