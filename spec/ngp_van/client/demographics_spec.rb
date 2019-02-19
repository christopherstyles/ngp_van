# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  # rubocop:disable Metrics/ClassLength
  class Client
    RSpec.describe Demographics do
      let(:client) { NgpVan::Client.new }

      let(:params) do
        {
          '$top' => 2
        }
      end

      before do
        stub_request(:get, url)
          .with(query: params)
          .to_return(
            body: response
          )
      end

      describe '#reported_races' do
        let(:response) { fixture('reported_races.json') }
        let(:url) { build_url(client: client, path: 'reportedRaces') }

        it 'requests the correct resource' do
          client.reported_races(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of items' do
          reported_races = client.reported_races(params: params)
          expect(reported_races['items']).to be_a(Array)
        end

        it 'returns the requested data' do
          reported_races = client.reported_races(params: params)
          expect(reported_races['items'].first['reportedRaceId']).to eq(2)
        end
      end

      describe '#reported_ethnicities' do
        let(:response) { fixture('reported_ethnicities.json') }
        let(:url) { build_url(client: client, path: 'reportedEthnicities') }

        it 'requests the correct resource' do
          client.reported_ethnicities(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of items' do
          reported_ethnicities = client.reported_ethnicities(params: params)
          expect(reported_ethnicities['items']).to be_a(Array)
        end

        it 'returns the requested data' do
          reported_ethnicities = client.reported_ethnicities(params: params)
          expect(reported_ethnicities['items'].first['reportedEthnicityId']).to eq(2)
        end
      end

      describe '#reported_language_preferences' do
        let(:response) { fixture('reported_language_preferences.json') }
        let(:url) { build_url(client: client, path: 'reportedLanguagePreferences') }

        it 'requests the correct resource' do
          client.reported_language_preferences(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of items' do
          languages = client.reported_language_preferences(params: params)
          expect(languages['items']).to be_a(Array)
        end

        it 'returns the requested data' do
          languages = client.reported_language_preferences(params: params)
          expect(languages['items'].first['reportedLanguagePreferenceId']).to eq(2)
        end
      end

      describe '#reported_sexual_orientations' do
        let(:response) { fixture('reported_sexual_orientations.json') }
        let(:url) { build_url(client: client, path: 'reportedSexualOrientations') }

        it 'requests the correct resource' do
          client.reported_sexual_orientations(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of items' do
          reported_sexual_orientations = client.reported_sexual_orientations(params: params)
          expect(reported_sexual_orientations['items']).to be_a(Array)
        end

        it 'returns the requested data' do
          reported_sexual_orientations = client.reported_sexual_orientations(params: params)
          expect(reported_sexual_orientations['items'].first['reportedSexualOrientationId']).to eq(2)
        end
      end

      describe '#reported_genders' do
        let(:response) { fixture('reported_genders.json') }
        let(:url) { build_url(client: client, path: 'reportedGenders') }

        it 'requests the correct resource' do
          client.reported_genders(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of items' do
          reported_genders = client.reported_genders(params: params)
          expect(reported_genders['items']).to be_a(Array)
        end

        it 'returns the requested data' do
          reported_genders = client.reported_genders(params: params)
          expect(reported_genders['items'].first['reportedGenderId']).to eq(19)
        end
      end

      describe '#pronouns' do
        let(:response) { fixture('pronouns.json') }
        let(:url) { build_url(client: client, path: 'pronouns') }

        it 'requests the correct resource' do
          client.pronouns(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of items' do
          pronouns = client.pronouns(params: params)
          expect(pronouns['items']).to be_a(Array)
        end

        it 'returns the requested data' do
          pronouns = client.pronouns(params: params)
          expect(pronouns['items'].first['preferredPronounId']).to eq(6)
        end
      end
    end
  end
end
