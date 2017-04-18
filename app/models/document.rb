class Document < ApplicationRecord
  belongs_to :attachable, polymorphic: true, optional: true

  has_attached_file :doc
  validates_attachment :doc, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }
end
