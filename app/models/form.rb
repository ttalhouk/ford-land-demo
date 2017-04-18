class Form < ApplicationRecord
  has_many :documents, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :documents
end
