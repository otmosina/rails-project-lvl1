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
        if attrs.any?
          " #{attrs.map { |k, v| v.nil? ? k.to_s : "#{k}=\"#{v}\"" }.join(' ')}"
        else
          ''
        end
      end
    end
  end
end
