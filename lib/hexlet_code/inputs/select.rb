# frozen_string_literal: true

module HexletCode
  module Inputs
    # class for build input select
    class Select
      def self.build(name, value, attritutes = {})
        collection = attritutes.delete(:collection)
        tag_attributes = { name: name }.merge!(attritutes)
        Tag.build('select', **tag_attributes) do
          collection.inject('') do |result, v|
            inter_tag_attrs = { value: v }
            inter_tag_attrs.merge!({ selected: '' }) if value == v
            result + Tag.build('option', **innter_tag_attrs) { v }
          end
        end
      end
    end
  end
end
