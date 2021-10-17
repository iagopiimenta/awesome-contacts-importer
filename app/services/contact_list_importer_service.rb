# frozen_string_literal: true

require 'csv'

class ContactListImporterService
  def initialize(contact_import:, async: false, csv_options: { col_sep: ';' })
    @contact_import = contact_import
    @csv_options = csv_options
    @async = async
  end

  def call
    @contact_import.status_processing!

    process_file
    check_progress
  end

  private

  def process_file
    @contact_import.contacts_file.open do |file|
      fetch_total_rows(file)

      CSV.foreach(file, @csv_options).with_index(1) do |row, line_number|
        process_contact(row, line_number)
      end
    end
  end

  def process_contact(row, line_number)
    if @async
      ProcessContactWorker.perform_async(@contact_import.id, row, line_number)
    else
      ContactImporterService.new(@contact_import, row, line_number).call
    end
  end

  def fetch_total_rows(file)
    total_rows = `wc -l #{file.path}`.to_i
    @contact_import.total_rows = total_rows
    @contact_import.save!
  end

  def check_progress
    @async ? CheckImportProgressWorker.perform_in(1.second, @contact_import.id) : @contact_import.check_progress!
  end
end
