# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  # rubocop:disable Metrics/ClassLength
  class Client
    RSpec.describe Contributions do
      let(:client) { NgpVan::Client.new }

      describe '#create_contribution' do
        let(:body) do
          JSON.parse(File.read(fixture_path + '/create_contribution.json'))
        end

        let(:response) { fixture('create_contribution_response.json') }
        let(:url) { build_url(client: client, path: 'contributions') }

        before do
          stub_request(:post, url)
            .with(body: JSON.generate(body))
            .to_return(
              status: 201,
              body: response
            )
        end

        it 'requests the correct resource' do
          client.create_contribution(body: body)
          expect(
            a_request(:post, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns the created id' do
          contrib = client.create_contribution(body: body)
          expect(contrib['contributionId']).to eq(1234567890)
        end
      end

      describe '#person' do
        let(:response) { fixture('contribution.json') }
        let(:url) { build_url(client: client, path: 'contributions/1234567890') }

        before do
          stub_request(:get, url)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.contribution(id: 1234567890)
          expect(
            a_request(:get, url)
          ).to have_been_made
        end

        it 'returns a person object' do
          contrib = client.contribution(id: 1234567890)
          expect(contrib).to be_a(Hash)
        end

        it 'returns the requested contribution' do
          contrib = client.contribution(id: 1234567890)
          expect(contrib['contributionId']).to eq(1234567890)
        end
      end

      describe '#contribution_by_type' do
        let(:response) { fixture('contribution.json') }
        let(:url) { build_url(client: client, path: 'contributions/onlineReferenceNumber:1230230423') }

        before do
          stub_request(:get, url)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.contribution_by_type(id: 1230230423, type: 'onlineReferenceNumber')
          expect(
            a_request(:get, url)
          ).to have_been_made
        end

        it 'returns a contribution object' do
          contrib = client.contribution_by_type(id: 1230230423, type: 'onlineReferenceNumber')
          expect(contrib).to be_a(Hash)
        end

        it 'returns the requested contribution' do
          contrib = client.contribution_by_type(id: 1230230423, type: 'onlineReferenceNumber')
          expect(contrib['onlineReferenceNumber']).to eq("1230230423")
        end
      end

      describe '#contribution_attribution_types' do
        let(:response) { fixture('contribution_attribution_types.json') }
        let(:url) { build_url(client: client, path: 'contributions/attributionTypes') }

        before do
          stub_request(:get, url)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.contribution_attribution_types
          expect(
            a_request(:get, url)
          ).to have_been_made
        end

        it 'returns a list of objects' do
          attrib_types = client.contribution_attribution_types
          expect(attrib_types["attributionTypes"]).to be_a(Array)
        end
      end

      describe '#create_or_update_contribution_attribution' do
        let(:body) do
          JSON.parse(File.read(fixture_path + '/attribution.json'))
        end

        let(:url) do
          build_url(client: client, path: 'contributions/1234567890/attributions/215501')
        end

        before do
          stub_request(:put, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: '',
              status: 204
            )
        end

        it 'requests the correct resource' do
          client.create_or_update_contribution_attribution(id: 1234567890, vanId: 215501, body: body)
          expect(
            a_request(:put, url)
              .with(body: JSON.generate(body))
          ).to have_been_made
        end

        it 'returns an empty response body' do
          expect(
            client.create_or_update_contribution_attribution(id: 1234567890, vanId: 215501, body: body)
          ).to eq('')
        end
      end

      describe '#delete_contribution_attribution' do
        let(:url) do
          build_url(client: client, path: 'contributions/1234567890/attributions/215501')
        end

        before do
          stub_request(:delete, url)
            .to_return(
              body: '',
              status: 204
            )
        end

        it 'requests the correct resource' do
          client.delete_contribution_attribution(id: 1234567890, vanId: 215501)
          expect(
            a_request(:delete, url)
          ).to have_been_made
        end

        it 'returns an empty response body' do
          expect(
            client.delete_contribution_attribution(id: 1234567890, vanId: 215501)
          ).to eq('')
        end
      end

      describe '#adjust_contribution' do
        let(:body) do
          JSON.parse(File.read(fixture_path + '/contribution_adjustment.json'))
        end
        let(:response_body) do
          File.read(fixture_path + '/contribution_adjustment_response.json')
        end

        let(:url) do
          build_url(client: client, path: 'contributions/1234567890/adjustments')
        end

        before do
          stub_request(:post, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: response_body,
              status: 200
            )
        end

        it 'requests the correct resource' do
          client.adjust_contribution(id: 1234567890, body: body)
          expect(
            a_request(:post, url)
              .with(body: JSON.generate(body))
          ).to have_been_made
        end

        it 'returns the response object' do
          expect(
            client.adjust_contribution(id: 1234567890, body: body)
          ).to eq(JSON.parse(response_body))
        end
      end
    end
  end
end
