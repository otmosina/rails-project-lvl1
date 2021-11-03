# frozen_string_literal: true

module HexletCode
  module Inputs
    # class for build input text
    class Textfield
      class << self
        def build(name, value, attritutes = {})
          tag_attributes = { type: 'text', name: name, value: value, **attritutes }
          tag_attributes.delete(:value) unless value
          Tag.build('input', **tag_attributes)
        end
      end
    end
  end
end
