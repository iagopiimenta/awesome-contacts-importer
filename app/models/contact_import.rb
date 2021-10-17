# frozen_string_literal: true

class ContactImport < ApplicationRecord
  enum status: { on_hold: 0, processing: 1, failed: 2, finished: 3 }, _prefix: true, _default: :on_hold

  belongs_to :user
  has_many :contacts, dependent: :nullify
  has_many :contact_faileds, dependent: :delete_all

  has_one_attached :contacts_file

  def check_progress!
    ContactImportProgressChecker.new(self, false).call
  end
end
