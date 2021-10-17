# frozen_string_literal: true

class ContactImporterService
  def initialize(contact_import, contact_data, line_number)
    @contact_import = contact_import
    @contact_data = contact_data
    @line_number = line_number
  end

  def call
    @contact_import.contacts.create!(contact_params)
  rescue ActiveRecord::RecordInvalid => e
    # TODO: save log
  end

  private

  def contact_params
    fields_order = @contact_import.fields_order || %w[name date_of_birth phone address credit_card email]
    params = fields_order.zip(@contact_data).to_h

    params.merge(user_id: @contact_import.user_id)
  end
end
