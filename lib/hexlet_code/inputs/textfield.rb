# frozen_string_literal: true

module HexletCode
  module Inputs
    # class for build input text
    class Textfield
      def self.build(name, value, attritutes = {})
        tag_attributes = { type: 'text', name: name, value: value }
        tag_attributes.merge!(attritutes)
        Tag.build('input', **tag_attributes)
      end
    end
  end
end
