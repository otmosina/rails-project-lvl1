# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength Layout/TrailingEmptyLines
RSpec.describe HexletCode do
  it 'has a version number' do
    expect(HexletCode::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(true).to eq(true)
  end

  context '.form_for' do
    let(:user) { Struct.new(:name, :job, keyword_init: true) }
    it 'return correct form' do
      expect(described_class.form_for(user)).to eq('<form action="#" method="post"></form>')
      expect(described_class.form_for(user, url: '/users')).to eq('<form action="/users" method="post"></form>')
    end

    context 'complex form_for' do
      let(:user_struct) { Struct.new(:name, :job, :gender, keyword_init: true) }
      let(:user) { user_struct.new name: 'rob', job: 'hexlet', gender: 'm' }
      let(:form) do
        HexletCode.form_for user do |f|
          f.input :name
          f.input :job, as: :text
          f.input :gender, as: :select, collection: %w[m f]
        end
      end
      let(:form_html) do
        html = ''
        html += '<form action="#" method="post">'
        html += '<label for="name">Name</label>'
        html += '<input type="text" name="name" value="rob">'
        html += '<label for="job">Job</label>'
        html += '<textarea name="job" cols="20" rows="40">hexlet</textarea>'
        html += '<label for="gender">Gender</label>'
        html += '<select name="gender">'
        html += '<option value="m" selected>m</option>'
        html += '<option value="f">f</option>'
        html += '</select>'

        html += '</form>'
        html
      end
      it 'return correct form' do
        expect(form).to eq(form_html)
      end
    end

    context 'complex form_for with submit & labels' do
      let(:user_struct) { Struct.new(:name, :job, keyword_init: true) }
      let(:user) { user_struct.new job: 'hexlet' }
      let(:form) do
        HexletCode.form_for user do |f|
          f.input :name
          f.input :job
          f.submit
        end
      end
      let(:form_html) do
        html = ''
        html += '<form action="#" method="post">'
        html += '<label for="name">Name</label>'
        html += '<input type="text" name="name">'
        html += '<label for="job">Job</label>'
        html += '<input type="text" name="job" value="hexlet">'
        html += '<input type="submit" value="Save" name="commit">'
        html += '</form>'
        html
      end
      it 'return correct form' do
        expect(form).to eq(form_html)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength Layout/TrailingEmptyLines
