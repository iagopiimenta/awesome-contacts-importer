# frozen_string_literal: true

class ContactImportsController < ApplicationController
  def index
    @contact_imports = current_user.contact_imports
  end

  def show
    current_user.contact_imports.find(params[:id])
  end

  def new
    @contact_import = current_user.contact_imports.build
  end

  def create
    @contact_import = current_user.contact_imports.build(contact_import_params)
    if @contact_import.save
      redirect_to @contact_import
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_import_params
    params.require(:contact_import).permit(:contacts_file, fields_order: [])
  end
end
