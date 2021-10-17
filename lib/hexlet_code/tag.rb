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

        attrs.reduce('') do |html, (k, v)|
          html + if v.nil?
                   %( #{k})
                 else
                   %( #{k}="#{v}")
                 end
        end
      end
    end
  end
end
