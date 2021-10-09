# frozen_string_literal: true

module FixtureHelper
  DIRECTORY = 'spec/fixtures/files/forms/'
  def read_html_file filename
    path = [DIRECTORY, filename].join
    html = File.read(path)
    html.gsub("\n", '')

  end
end