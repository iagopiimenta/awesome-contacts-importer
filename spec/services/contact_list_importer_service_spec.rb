# frozen_string_literal: true

require 'rails_helper'
RSpec.describe ContactListImporterService do
  describe '#call' do
    let(:user) { User.create!(email: 'user@gmail.com', password: '12345678') }
    let!(:contact_import) do
      ContactImport.create!(fields_order: ContactImport::MAPPING_FIELDS, user: user) do |contact_import|
        contact_import.contacts_file.attach(
          io: file_fixture("contact_list.csv").open,
          filename: 'test.csv',
          content_type: 'text/csv'
        )
      end
    end

    it 'import valid contacts' do
      service = described_class.new(contact_import: contact_import, async: false)

      expect do
        service.call
      end.to change { user.contacts.count }.to(3)
    end

    it 'save invalid contacts logs' do
      service = described_class.new(contact_import: contact_import, async: false)

      expect do
        service.call
      end.to change { user.contact_faileds.count }.to(8)
    end

    context 'when async is enabled' do
      it 'save valid contacts' do
        Sidekiq::Testing.inline! do
          service = described_class.new(contact_import: contact_import, async: true)

          expect do
            service.call
          end.to change { user.contacts.count }.to(3)
        end
      end
    end
  end
end
