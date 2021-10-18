# frozen_string_literal: true

class ContactsController < ApplicationController
  def index
    @contacts = current_user.contacts.order(:created_at).page(params[:page])

    return unless params[:contact_import_id]

    @contact_import = current_user.contact_imports.find(params[:contact_import_id])
    @contacts = @contacts.where(contact_import: @contact_import)
  end
end
