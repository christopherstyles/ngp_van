# frozen_string_literal: true

module NgpVan
  class Client
    module People
      def find_person(body: {})
        post(path: 'people/find', body: body)
      end

      def find_or_create_person(body: {})
        post(path: 'people/findOrCreate', body: body)
      end

      def person(id:, params: {})
        verify_id(id)
        get(path: "people/#{id}", params: params)
      end

      def person_by_type(id:, type:, params: {})
        verify_ids(id, type)
        get(path: "people/#{type}:#{id}", params: params)
      end

      def create_canvass_responses_for_person(id:, body: {})
        verify_id(id)
        post(path: "people/#{id}/canvassResponses", body: body)
      end

      def create_canvass_responses_for_person_by_type(id:, type:, body: {})
        verify_ids(id, type)
        post(path: "people/#{type}:#{id}/canvassResponses", body: body)
      end

      def apply_code_to_person(id:, body: {})
        verify_id(id)
        post(path: "people/#{id}/codes", body: body)
      end

      def delete_code_from_person(id:, codeId:)
        verify_ids(id, codeId)
        delete(path: "people/#{id}/codes/#{codeId}")
      end
    end
  end
end
