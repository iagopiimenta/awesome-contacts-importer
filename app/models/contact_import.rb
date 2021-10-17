# frozen_string_literal: true

class ContactImport < ApplicationRecord
  enum status: { on_hold: 0, processing: 1, failed: 2, finished: 3 }, _prefix: true

  belongs_to :user
  has_many :contacts, dependent: :nullify

  has_one_attached :contacts_file
end
