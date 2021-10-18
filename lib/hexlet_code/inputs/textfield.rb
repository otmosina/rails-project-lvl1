# frozen_string_literal: true

module HexletCode
  module Inputs
  # class for build input text
    class Textfield
      def self.build(name, value, attritutes = {})
        tag_attributes = { type: 'text', name: name }
        tag_attributes.merge!(attritutes)
        tag_attributes.merge!({ value: value }) unless value.nil?
        Tag.build('input', **tag_attributes)
      end
    end
  end
end
