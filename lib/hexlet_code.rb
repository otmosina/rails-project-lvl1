# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  # Class to generate html tags
  class Tag
    def self.build(name, **attrs)
      html = "<#{name}"
      attrs.each_pair do |k, v|
        html += " "
        html += "#{k}=\"#{v}\""
      end
      html += if block_given?
        ">#{yield}</#{name}>"
      else
        ">"
      end
    end
  end
end
