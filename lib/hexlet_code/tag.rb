# frozen_string_literal: true

module HexletCode
  # Class to generate html tags
  class Tag
    class << self
      VOID_TAGS = %(area, base, br, col, embed, hr, img, input, link, meta, param, source, track, wbr)
      def build(name, **attrs, &block)
        attrs = prepare_attrs(attrs)
        unless void_tag?(block)
          "<#{name}#{render_tag_attrs(attrs)}>"
        else
          "<#{name}#{render_tag_attrs(attrs)}>#{block.call}</#{name}>"
        end
      end

      private

      def prepare_attrs attrs
        attrs.delete(:value) unless attrs[:value]
        attrs = attrs.map { |k, v| %( #{k}="#{v}") }
        attrs
      end

      def void_tag?(block)
        !!block
        #VOID_TAGS.include? name
      end

      def render_tag_attrs(attrs)
        attrs.join
      end
    end
  end
end
