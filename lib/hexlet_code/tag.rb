# frozen_string_literal: true

module HexletCode
  # Class to generate html tags
  class Tag
    class << self
      def build(name, **attrs)
        if block_given?
          "<#{name}#{render_tag_attrs(attrs)}>#{yield}</#{name}>"
        else
          "<#{name}#{render_tag_attrs(attrs)}>"
        end
      end

      private

      def render_tag_attrs(attrs)
        return '' if attrs.empty?
        " #{attrs.map { |k, v| v.nil? ? k.to_s : "#{k}=\"#{v}\"" }.join(' ')}"
      end
    end
  end
end
