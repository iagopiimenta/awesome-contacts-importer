# frozen_string_literal: true

class ContactFailed < ApplicationRecord
  belongs_to :contact_import
  belongs_to :user
end
