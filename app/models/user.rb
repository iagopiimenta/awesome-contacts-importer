# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contact_imports, dependent: :delete_all
  has_many :contacts, dependent: :delete_all
  has_many :contact_faileds, dependent: :delete_all
end
