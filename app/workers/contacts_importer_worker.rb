# frozen_string_literal: true

class ContactsImporterWorker
  include Sidekiq::Worker

  def perform(contact_import_id)
    contact_import = ContactImport.find(contact_import_id)
    ContactListImporterService.new(contact_import: contact_import, async: true).call
  end
end
