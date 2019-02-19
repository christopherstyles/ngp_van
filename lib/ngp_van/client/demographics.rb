# frozen_string_literal: true

module NgpVan
  class Client
    module Demographics
      def reported_races(params: {})
        get(path: 'reportedRaces', params: params)
      end

      def reported_ethnicities(params: {})
        get(path: 'reportedEthnicities', params: params)
      end

      def reported_language_preferences(params: {})
        get(path: 'reportedLanguagePreferences', params: params)
      end

      def reported_sexual_orientations(params: {})
        get(path: 'reportedSexualOrientations', params: params)
      end

      def reported_genders(params: {})
        get(path: 'reportedGenders', params: params)
      end

      def pronouns(params: {})
        get(path: 'pronouns', params: params)
      end
    end
  end
end
