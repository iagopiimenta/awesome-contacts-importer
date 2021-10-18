# frozen_string_literal: true

class ContactImport < ApplicationRecord
  MAPPING_FIELDS = %w[name date_of_birth phone address credit_card email].freeze
  enum status: { on_hold: 0, processing: 1, failed: 2, finished: 3 }, _prefix: true, _default: :on_hold

  belongs_to :user
  has_many :contacts, dependent: :nullify
  has_many :contact_faileds, dependent: :delete_all

  has_one_attached :contacts_file

  validates :contacts_file, presence: true, blob: { content_type: ['text/csv'], size_range: 1..(10.megabytes) }
  validates :fields_order, presence: true
  validate :fields_order_valid?

  after_create :import_contacts_async!

  def check_progress!
    ContactImportProgressChecker.new(self, enqueue: false).call
  end

  def import_contacts_async!
    ContactsImporterWorker.perform_async(id)
  end

  private

  def fields_order_valid?
    return if fields_order.blank?
    return if (fields_order & MAPPING_FIELDS).size == MAPPING_FIELDS.size && fields_order.size == fields_order.uniq.size

    errors.add(:fields_order, 'is invalid')
  end
end
