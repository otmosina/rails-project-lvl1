# frozen_string_literal: true

RSpec.describe HexletCode::Tag do
  it 'return correct html tags' do
    expect(HexletCode::Tag.build('br')).to eq('<br>')
    expect(HexletCode::Tag.build('img', src: 'path/to/image')).to eq('<img src="path/to/image">')
    expect(HexletCode::Tag.build('input', type: 'submit', value: 'Save')).to eq('<input type="submit" value="Save">')
    expect(HexletCode::Tag.build('label') { 'Email' }).to eq('<label>Email</label>')
    expect(HexletCode::Tag.build('label', for: 'email') { 'Email' }).to eq('<label for="email">Email</label>')
  end
end
