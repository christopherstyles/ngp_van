# frozen_string_literal: true

module NgpVan
  class Client
    module Contributions
      def create_contribution(body: {})
        post(path: 'contributions', body: body)
      end

      def contribution(id:)
        verify_id(id)
        get(path: "contributions/#{id}")
      end

      def contribution_by_type(id:, type:)
        verify_ids(id, type)
        get(path: "contributions/#{type}:#{id}")
      end

      def contribution_attribution_types
        get(path: 'contributions/attributionTypes')
      end

      def create_or_update_contribution_attribution(id:, vanId:, body: {})
        verify_ids(id, vanId)
        put(path: "contributions/#{id}/attributions/#{vanId}", body: body)
      end

      def delete_contribution_attribution(id:, vanId:)
        verify_ids(id, vanId)
        delete(path: "contributions/#{id}/attributions/#{vanId}")
      end

      def adjust_contribution(id:, body: {})
        verify_ids(id)
        post(path: "contributions/#{id}/adjustments", body: body)
      end
    end
  end
end
