# frozen_string_literal: true

require_relative 'hexlet_code/version'

# module simple for html generation
module HexletCode
  class Error < StandardError; end

  def self.form_for(model, url: '#')
    Tag.build('form', action: url, method: 'post') do
      yield(Form.new(model)) if block_given?
    end
  end

  # class for make form object
  class Form
    attr_reader :model

    def initialize(model)
      @model = model
      @inner_html = ''
    end

    def input(name, **params)
      value = model.send name
      as, tag_attributes = handle_params(params)

      @inner_html += Tag.build('label', for: name) { name.capitalize }
      @inner_html += AsParamMapper.call(as).build(name, value, tag_attributes)
    end

    def submit(value = 'Save')
      @inner_html += Tag.build('input', type: 'submit', value: value, name: 'commit')
    end

    private

    def handle_params(params)
      as_param = params[:as]
      tag_attributes = params.dup
      tag_attributes.delete(:as)
      [as_param, tag_attributes]
    end
  end

  # class for build input text
  class Textfield
    def self.build(name, value, attritutes = {})
      tag_attributes = { type: 'text', name: name, value: value }
      tag_attributes.merge!(attritutes)
      tag_attributes.delete(:value) if value.nil?
      Tag.build('input', **tag_attributes)
    end
  end

  # class for build input textarea
  class Textarea
    def self.build(name, value, attritutes = {})
      tag_attributes = { name: name, cols: 20, rows: 40 }
      tag_attributes.merge!(attritutes)
      Tag.build('textarea', **tag_attributes) { value }
    end
  end

  # class for build input select
  class Select
    def self.build(name, value, attritutes = {})
      render_options = attritutes[:collection].inject('') do |result, v|
        result + if value == v
                   Tag.build('option', value: v, selected: nil) { v }
                 else
                   Tag.build('option', value: v) { v }
                 end
      end
      Tag.build('select', name: name) do
        render_options
      end
    end
  end

  # Class to generate html tags
  class Tag
    def self.build(name, **attrs)
      html = "<#{name}"
      attrs.each_pair do |k, v|
        html += ' '
        html += v.nil? ? k.to_s : "#{k}=\"#{v}\""
      end
      html += block_given? ? ">#{yield}</#{name}>" : '>'
    end
  end

  # class to map as param to class
  class AsParamMapper
    MAP = {
      text: Textarea,
      select: Select,
      nil => Textfield
    }.freeze
    def self.call(as_value)
      MAP[as_value]
    end
  end
end
