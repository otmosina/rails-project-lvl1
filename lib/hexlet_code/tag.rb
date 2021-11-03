# frozen_string_literal: true

module HexletCode
  # Class to generate html tags
  class Tag
    class << self
      def build(name, **attrs, &block)
        if paired_tag?(block)
          "<#{name}#{render_tag_attrs(attrs)}>#{block.call}</#{name}>"
        else
          "<#{name}#{render_tag_attrs(attrs)}>"
        end
      end

      private

      def paired_tag?(block)
        !!block
      end

      def render_tag_attrs(attrs)
        attrs.map { |k, v| %( #{k}="#{v}") }.join
      end
    end
  end
end
