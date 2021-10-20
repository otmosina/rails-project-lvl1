# frozen_string_literal: true

module HexletCode
  # Class to generate html tags
  class Tag
    class << self
      VOID_TAGS = %(area, base, br, col, embed, hr, img, input, link, meta, param, source, track, wbr)
      def build(name, **attrs)
        if void_tag?(name)
          "<#{name}#{render_tag_attrs(attrs)}>"
        else
          "<#{name}#{render_tag_attrs(attrs)}>#{yield}</#{name}>"
        end
      end

      private

      def void_tag?(name)
        VOID_TAGS.include? name
      end

      def render_tag_attrs(attrs)
        return '' if attrs.empty?

        attrs.reduce('') do |html, (k, v)|
          return html if v.nil?
          return html + %( #{k}) if v.to_s.empty?

          html + %( #{k}="#{v}")
        end
      end
    end
  end
end
