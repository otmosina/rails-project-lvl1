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
    def initialize(model)
      @model = model
      @inner_html = ''
    end

    def input(name, **params)
      value = @model.send name
      as_param = params.delete(:as)

      @inner_html += Tag.build('label', for: name) { name.capitalize }
      @inner_html += AsParamMapper.call(as_param).build(name, value, params)
    end

    def submit(value = 'Save')
      @inner_html += Tag.build('input', type: 'submit', value: value, name: 'commit')
    end
  end

  # class for build input text
  class Textfield
    def self.build(name, value, attritutes = {})
      tag_attributes = { type: 'text', name: name }
      tag_attributes.merge!(attritutes)
      tag_attributes.merge!({ value: value }) unless value.nil?
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
      collection = attritutes.delete(:collection)
      tag_attributes = { name: name }
      tag_attributes.merge!(attritutes)
      Tag.build('select', **tag_attributes) do
        collection.inject('') do |result, v|
          result + if value == v
                     Tag.build('option', value: v, selected: nil) { v }
                   else
                     Tag.build('option', value: v) { v }
                   end
        end
      end
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
