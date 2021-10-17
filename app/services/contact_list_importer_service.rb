# frozen_string_literal: true

class ContactListImporterService
  def initialize(contact_import, csv_options = { col_sep: ';' })
    @contact_import = contact_import
    @csv_options = csv_options
  end

  def call
    @contact_import.contacts_file.open do |file|
      fetch_total_rows(file)

      CSV.foreach(file, @csv_options).with_index do |row, ln|
        ContactImporterService.new(@contact_import, row, ln).call
      end
    end

    check_progress
  end

  private

  def fetch_total_rows(file)
    total_rows = `wc -l #{file.path}`.to_i
    @contact_import.total_rows = total_rows
    @contact_import.save!
  end

  def check_progress
    # TODO
  end
end
