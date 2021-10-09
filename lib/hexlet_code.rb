# frozen_string_literal: true

require_relative 'hexlet_code/version'

# module simple for html generation
module HexletCode
  class Error < StandardError; end
  autoload :Textfield, './lib/hexlet_code/textfield.rb'
  autoload :Text, './lib/hexlet_code/text.rb'
  autoload :Select, './lib/hexlet_code/select.rb'

  def self.form_for(model, url: '#')
    Tag.build('form', action: url, method: 'post') do
      yield(Form.new(model)) if block_given?
    end
  end

  # class for make form object
  class Form
    def initialize(model)
      @model = model
      @inner_html = ''
    end

    def input(name, **params)
      value = @model.send name
      as_param = params.delete(:as) || 'Textfield'
      as_param = as_param.downcase.capitalize

      @inner_html += Tag.build('label', for: name) { name.capitalize }
      @inner_html += HexletCode.const_get(as_param).build(name, value, params)
    end

    def submit(value = 'Save')
      @inner_html += Tag.build('input', type: 'submit', value: value, name: 'commit')
    end
  end

  # Class to generate html tags
  class Tag
    def self.build(name, **attrs)
      html = "<#{name}"
      html += ' ' unless attrs.empty?
      html += attrs.map do |k, v|
        v.nil? ? k.to_s : "#{k}=\"#{v}\""
      end.join(' ')
      html += block_given? ? ">#{yield}</#{name}>" : '>'
      html
    end
  end
end
