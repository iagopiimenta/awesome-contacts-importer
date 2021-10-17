# frozen_string_literal: true

class ProcessContactWorker
  include Sidekiq::Worker

  def perform(contact_import_id, contact_data, line_number)
    contact_import = ContactImport.find(contact_import_id)
    ContactImporterService.new(contact_import, contact_data, line_number).call
  end
end
