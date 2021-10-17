# frozen_string_literal: true

class ContactImportProgressChecker
  def initialize(contact_import, enqueue: false, previous_total_processed: 0, attempts: 0)
    @contact_import = contact_import
    @enqueue = enqueue
    @previous_total_processed = previous_total_processed
    @attempts = attempts
  end

  def call
    return unless @contact_import.status_processing?

    check_progress!
  end

  private

  def check_progress!
    return enqueue_job if total_processed < @contact_import.total_rows

    if total_imported.positive?
      @contact_import.status_finished!
    else
      @contact_import.status_failed!
    end
  end

  def enqueue_job
    return unless @enqueue

    if @previous_total_processed == total_processed
      @attempts += 1
    else
      @attempts = 0
    end

    CheckImportProgressWorker.perform_in(2.seconds, @contact_import.id, total_processed, @attempts)
  end

  def total_processed
    total_imported + total_failed
  end

  def total_imported
    @total_imported ||= @contact_import.contacts.count
  end

  def total_failed
    @total_failed ||= @contact_import.contact_faileds.count
  end
end
