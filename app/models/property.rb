class Property < ApplicationRecord
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :documents, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :pictures
  accepts_nested_attributes_for :documents
end
