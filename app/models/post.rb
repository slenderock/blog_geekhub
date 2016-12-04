# frozen_string_literal: true
# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  cover      :string
#

class Post < ApplicationRecord
  mount_uploader :cover, CoverUploader
  belongs_to :user

  has_many :comments, as: :commentable

  validates :user_id, presence: true
  validates :title, presence: true
end
