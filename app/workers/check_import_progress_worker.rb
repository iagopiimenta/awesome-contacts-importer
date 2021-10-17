# frozen_string_literal: true

class CheckImportProgressWorker
  include Sidekiq::Worker

  def perform(contact_import_id, previous_total_processed = 0, attempts = 0)
    contact_import = ContactImport.find(contact_import_id)
    return if attempts > 10 # stop if previous_total_processed still the same after 10 attempts

    ContactImportProgressChecker.new(contact_import, true, previous_total_processed, attempts).call
  end
end
