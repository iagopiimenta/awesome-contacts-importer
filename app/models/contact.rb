# frozen_string_literal: true
require 'bcrypt'

class Contact < ApplicationRecord
  VALID_DATE_REGEX = /\A(\d{4}-\d{2}-\d{2})|(\d{8})\z/.freeze
  VALID_PHONE_REGEX = /\A(\(\+\d{2}\)( \d{3}){2}( \d{2}){2})|(\(\+\d{2}\) (\d{3}-){2}\d{2}-\d{2})\z/.freeze
  VALID_NAME_REGEX = /\A[0-9a-zA-Z -]+\z/.freeze

  belongs_to :user

  attr_accessor :credit_card

  validates :email, email: true
  validates :email, presence: true, uniqueness: { scope: :user_id }, unless: -> { errors.include?(:email) }
  validates :name, format: { with: VALID_NAME_REGEX }, presence: true
  validates :date_of_birth, presence: true
  validates :phone, format: { with: VALID_PHONE_REGEX }, presence: true
  validates :address, presence: true

  validate :credit_card_valid?

  def date_of_birth=(value)
    return unless value.is_a?(Time) || value =~ VALID_DATE_REGEX

    super(value)
  end

  def credit_card=(value)
    detector = CreditCardValidations::Detector.new(value)
    return unless detector.valid?

    self.credit_card_hash = BCrypt::Password.create(value)
    self.credit_card_issuer = detector.brand
    self.credit_card_last = value.gsub(/\D/, '')[-4..]
  end

  private

  def credit_card_valid?
    errors.add(:credit_card, "is invalid") if credit_card_hash.blank?
  end
end
