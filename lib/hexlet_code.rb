# frozen_string_literal: true

require_relative "hexlet_code/version"

# module simple for html generation
module HexletCode
  class Error < StandardError; end

  # class for make form object
  class Form
    @@input_with_label = true
    def self.input_with_label=(flag)
      @@input_with_label = flag
    end
    attr_reader :model

    def initialize(model)
      @model = model
      @inner_html = ""
    end

    def input(name, **params)
      value = model.send name
      @inner_html += case params[:as]
                     when :text
                       Tag.build("textarea", cols: "20", rows: "40", name: name) { value }
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

                       if @@input_with_label
                         input_params = { type: "text", name: name, value: value }
                         input_params.delete(:value) if value.nil?
                         Tag.build("label", for: name) { name.capitalize } +
                           Tag.build("input", **input_params)
                       else
                         input_params = { type: "text", value: value, name: name }
                         input_params.delete(:value) if value.nil?
                         Tag.build("input", **input_params)
                       end
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
