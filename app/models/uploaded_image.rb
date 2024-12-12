require "active_storage_validations"
require "open-uri"

class UploadedImage < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 100, 100 ]
    attachable.variant :medium, resize_to_limit: [ 300, 300 ]
  end

  validates :image, content_type: [ "image/png", "image/jpeg", "image/jpg" ],
                    size: { less_than: 5.megabytes },
                    presence: true

  def upload_to_cloudinary(image_file)
    cloudinary_response = Cloudinary::Uploader.upload(image_file)
    self.image.attach(
      io: URI.open(cloudinary_response["secure_url"]),
      filename: "upfile_\#{id}.jpg",
      content_type: "image/jpeg"
    )
    save!
  rescue OpenURI::HTTPError => e
    Rails.logger.error "Failed to open Cloudinary URL: \#{e.message}"
    raise "Failed to attach Cloudinary image"
  end
end
