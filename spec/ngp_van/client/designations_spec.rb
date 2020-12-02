# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  # rubocop:disable Metrics/ClassLength
  class Client
    RSpec.describe Designations do
      let(:client) { NgpVan::Client.new }

      describe '#designations' do
        let(:response) { fixture('designations.json') }
        let(:url) { build_url(client: client, path: 'designations') }

        before do
          stub_request(:get, url)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.designations
          expect(
            a_request(:get, url)
          ).to have_been_made
        end

        it 'returns an array of items' do
          designations = client.designations
          expect(designations['items']).to be_a(Array)
        end

        it 'returns the requested designations' do
          designations = client.designations
          expect(designations['items'].first['designationId']).to eq(123456789)
        end
      end
    end
  end
end
