# frozen_string_literal: true

require_relative 'hexlet_code/version'

# module simple for html generation
module HexletCode
  class Error < StandardError; end
  autoload :Textfield, 'hexlet_code/textfield.rb'
  autoload :Text, 'hexlet_code/text.rb'
  autoload :Select, 'hexlet_code/select.rb'
  autoload :Tag, 'hexlet_code/tag.rb'

  def self.form_for(model, url: '#')
    Tag.build('form', action: url, method: 'post') do
      yield(Form.new(model)).render if block_given?
    end
  end

  # class for make form object
  class Form
    def initialize(model)
      @model = model
      @tags = []
    end

    def input(name, **params)
      value = @model.send name
      as_param = (params.delete(:as) || 'Textfield').downcase.capitalize

      @tags << Tag.build('label', for: name) { name.capitalize }
      @tags << HexletCode.const_get(as_param).build(name, value, params)
      self
    end

    def submit(value = 'Save')
      @tags << Tag.build('input', type: 'submit', value: value, name: 'commit')
      self
    end

    def render
      @tags.join
    end
  end
end
