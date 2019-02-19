# frozen_string_literal: true

require 'ngp_van/connection'
require 'ngp_van/request'
require 'ngp_van/response'
require 'ngp_van/client/activist_codes'
require 'ngp_van/client/canvass_responses'
require 'ngp_van/client/codes'
require 'ngp_van/client/demographics'
require 'ngp_van/client/district_fields'
require 'ngp_van/client/echoes'
require 'ngp_van/client/events'
require 'ngp_van/client/event_types'
require 'ngp_van/client/locations'
require 'ngp_van/client/notes'
require 'ngp_van/client/people'
require 'ngp_van/client/printed_lists'
require 'ngp_van/client/minivan_exports'
require 'ngp_van/client/signups'
require 'ngp_van/client/survey_questions'
require 'ngp_van/client/supporter_groups'
require 'ngp_van/client/users'

module NgpVan
  class Client

    def initialize(configuration = nil)
      @config = configuration
    end

    def config
      @config || NgpVan.configuration
    end

    include NgpVan::Connection
    include NgpVan::Request
    include NgpVan::Response
    include NgpVan::Client::ActivistCodes
    include NgpVan::Client::CanvassResponses
    include NgpVan::Client::Codes
    include NgpVan::Client::Demographics
    include NgpVan::Client::DistrictFields
    include NgpVan::Client::Echoes
    include NgpVan::Client::Events
    include NgpVan::Client::EventTypes
    include NgpVan::Client::Locations
    include NgpVan::Client::Notes
    include NgpVan::Client::People
    include NgpVan::Client::PrintedLists
    include NgpVan::Client::MinivanExports
    include NgpVan::Client::Signups
    include NgpVan::Client::SupporterGroups
    include NgpVan::Client::SurveyQuestions
    include NgpVan::Client::Users
  end
end
