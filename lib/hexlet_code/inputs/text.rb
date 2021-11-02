# frozen_string_literal: true

module HexletCode
  module Inputs
    # class for build input textarea
    class Text
      class << self
        def build(name, value, attritutes = {})
          tag_attributes = { name: name, cols: 20, rows: 40, **attritutes }
          Tag.build('textarea', **tag_attributes) { value }
        end
      end
    end
  end
end
