# frozen_string_literal: true

module NgpVan
  class Client
    module Designations
      def designations
        get(path: 'designations')
      end
    end
  end
end
