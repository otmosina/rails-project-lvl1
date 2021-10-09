# frozen_string_literal: true

module HexletCode
  # class for build input textarea
  class Text
    def self.build(name, value, attritutes = {})
      tag_attributes = { name: name, cols: 20, rows: 40 }
      tag_attributes.merge!(attritutes)
      Tag.build('textarea', **tag_attributes) { value }
    end
  end
end
