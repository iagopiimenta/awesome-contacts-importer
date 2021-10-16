# frozen_string_literal: true

class ContactImport < ApplicationRecord
  enum status: [ :on_hold, :processing, :failed, :finished], _prefix: true

  belongs_to :user
  has_many :contacts
end
