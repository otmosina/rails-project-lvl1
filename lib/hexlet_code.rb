# frozen_string_literal: true

require_relative "hexlet_code/version"

# module simple for html generation
module HexletCode
  class Error < StandardError; end

  # class for make form object
  class Form
    attr_reader :model

    def initialize(model)
      @model = model
      @inner_html = ""
    end

    def input(name, **params)
      value = model.send name
      input_params = params.dup
      input_params.delete(:as)

      @inner_html += Tag.build("label", for: name) { name.capitalize }
      @inner_html += case params[:as]

                     when :text
                       input_params = {
                         name: name,
                         cols: 20,
                         rows: 40
                       }.merge(input_params)

                       Tag.build("textarea", **input_params) { value }
                     when :select
                       Tag.build("select", name: name) do
                         params[:collection].inject("") do |result, v|
                           result + if value == v
                                      Tag.build("option", value: v, selected: nil) { v }
                                    else
                                      Tag.build("option", value: v) { v }
                                    end
                         end
                       end
                     else

                       input_params = { type: "text", name: name, value: value }
                       input_params.merge!(params)
                       input_params.delete(:value) if value.nil?
                       Tag.build("input", **input_params)
                     end
    end

    def submit(value = "Save")
      @inner_html += Tag.build("input", type: "submit", value: value, name: "commit")
    end
  end

  def self.form_for(model, url: "#")
    Tag.build("form", action: url, method: "post") do
      yield(Form.new(model)) if block_given?
    end
  end

  # Class to generate html tags
  class Tag
    def self.build(name, **attrs)
      html = "<#{name}"
      attrs.each_pair do |k, v|
        html += " "
        html += if v.nil?
                  k.to_s
                else
                  "#{k}=\"#{v}\""
                end
      end
      html += if block_given?
                ">#{yield}</#{name}>"
              else
                ">"
              end
    end
  end
end
