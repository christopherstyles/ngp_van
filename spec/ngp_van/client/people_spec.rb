# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  # rubocop:disable Metrics/ClassLength
  class Client
    RSpec.describe People do
      let(:client) { NgpVan::Client.new }

      describe '#find_person' do
        let(:body) do
          JSON.parse(File.read(fixture_path + '/match_candidate.json'))
        end

        let(:response) { fixture('match_response.json') }
        let(:url) { build_url(client: client, path: 'people/find') }

        before do
          stub_request(:post, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.find_person(body: body)
          expect(
            a_request(:post, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns the match' do
          match = client.find_person(body: body)
          expect(match['vanId']).to eq(1_264_324)
        end
      end

      describe '#find_or_create_person' do
        let(:body) do
          JSON.parse(File.read(fixture_path + '/match_candidate.json'))
        end

        let(:response) { fixture('match_response.json') }
        let(:url) { build_url(client: client, path: 'people/findOrCreate') }

        before do
          stub_request(:post, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.find_or_create_person(body: body)
          expect(
            a_request(:post, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns the match' do
          match = client.find_or_create_person(body: body)
          expect(match['vanId']).to eq(1_264_324)
        end
      end

      describe '#person' do
        let(:params) do
          {
            '$expand' => 'phones,emails,addresses'
          }
        end

        let(:response) { fixture('person.json') }
        let(:url) { build_url(client: client, path: 'people/215501') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.person(id: 215_501, params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns a person object' do
          person = client.person(id: 215_501, params: params)
          expect(person).to be_a(Hash)
        end

        it 'returns the requested person' do
          person = client.person(id: 215_501, params: params)
          expect(person['vanId']).to eq(215_501)
        end
      end

      describe '#person_by_type' do
        let(:params) do
          {
            '$expand' => 'phones,emails,addresses'
          }
        end

        let(:response) { fixture('person.json') }
        let(:url) { build_url(client: client, path: 'people/dwid:215501') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.person_by_type(id: 215_501, type: 'dwid', params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns a person object' do
          person = client.person_by_type(id: 215_501, type: 'dwid',
                                         params: params)
          expect(person).to be_a(Hash)
        end

        it 'returns the requested person' do
          person = client.person_by_type(id: 215_501, type: 'dwid',
                                         params: params)
          expect(person['vanId']).to eq(215_501)
        end
      end

      describe '#create_canvass_responses_for_person' do
        let(:body) do
          JSON.parse(File.read(fixture_path + '/canvass_response.json'))
        end

        let(:url) do
          build_url(client: client, path: 'people/215501/canvassResponses')
        end

        before do
          stub_request(:post, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: '',
              status: 204
            )
        end

        it 'requests the correct resource' do
          client.create_canvass_responses_for_person(id: 215_501, body: body)
          expect(
            a_request(:post, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns an empty response body' do
          expect(
            client.create_canvass_responses_for_person(id: 215_501, body: body)
          ).to eq('')
        end
      end

      describe '#create_canvass_responses_for_person_by_type' do
        let(:body) do
          JSON.parse(File.read(fixture_path + '/canvass_response.json'))
        end

        let(:url) do
          build_url(client: client, path: 'people/dwid:215501/canvassResponses')
        end

        before do
          stub_request(:post, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: '',
              status: 204
            )
        end

        it 'requests the correct resource' do
          client.create_canvass_responses_for_person_by_type(
            id: 215_501, type: 'dwid', body: body
          )

          expect(
            a_request(:post, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns an empty response body' do
          expect(
            client.create_canvass_responses_for_person_by_type(
              id: 215_501, type: 'dwid', body: body
            )
          ).to eq('')
        end
      end

      describe '#apply_code_to_person' do
        let(:url) { build_url(client: client, path: 'people/123123/codes') }
        let(:request_body) { {'codeId' => 123456} }

        before do
          stub_request(:post, url)
            .with(body: request_body.to_json)
            .to_return(status: 204)
        end

        it 'sends the correct request' do
          client.apply_code_to_person(id: 123123, body: request_body)
          expect(
            a_request(:post, url)
              .with(
                body: request_body
              )
          ).to have_been_made
        end

        it 'returns the empty response body' do
          expect(
            client.apply_code_to_person(id: 123123, body: request_body)
          ).to eq('')
        end
      end

      describe '#delete_code_from_person' do
        let(:url) { build_url(client: client, path: 'people/215501/codes/123') }

        before do
          stub_request(:delete, url)
            .to_return(status: 204)
        end

        it 'requests the correct resource' do
          client.delete_code_from_person(id: 215_501, codeId: 123)
          expect(
            a_request(:delete, url)
          ).to have_been_made
        end

        it 'returns an empty response body' do
          expect(
            client.delete_code_from_person(id: 215_501, codeId: 123)
          ).to eq('')
        end
      end
    end
  end
end
