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
    save_failed(e)
  end

  private

  def save_failed(exception)
    @contact_import.contact_faileds.find_or_create_by!(
      user_id: @contact_import.user_id,
      line_number: @line_number
    ) do |contact_failed|
      # TODO: use habtm association
      contact_failed.messages = exception.record.errors.full_messages
    end
  end

  def contact_params
    fields_order = @contact_import.fields_order
    params = fields_order.zip(@contact_data).to_h

    params.merge(user_id: @contact_import.user_id)
  end
end
