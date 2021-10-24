# frozen_string_literal: true

require_relative 'hexlet_code/version'

# module simple for html generation
module HexletCode
  autoload :Tag, 'hexlet_code/tag.rb'
  autoload :Inputs, 'hexlet_code/inputs.rb'

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

      as_param = (params.delete(:as) || 'Textfield').downcase.capitalize.to_s
      as_param = "Inputs::#{as_param}"

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
