# frozen_string_literal: true

class ContactFailedsController < ApplicationController
  def index
    @contact_import = current_user.contact_imports.find(params[:contact_import_id])
    @contact_faileds = @contact_import.contact_faileds.order(:line_number).page(params[:page])
  end
end
