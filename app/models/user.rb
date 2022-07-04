# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3 }
  validates :name, uniqueness: true
end
