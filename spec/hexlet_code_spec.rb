# frozen_string_literal: true

User = Struct.new(:name, :job, :gender, keyword_init: true)
RSpec.describe HexletCode do
  it "has a version number" do
    expect(HexletCode::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(true).to eq(true)
  end

  context ".form_for" do
    let(:user) { Struct.new(:name, :job, keyword_init: true) }
    it "return correct form" do
      expect(described_class.form_for(user)).to eq('<form action="#" method="post"></form>')
      expect(described_class.form_for(user, url: "/users")).to eq('<form action="/users" method="post"></form>')
    end

    context "comples form_for" do
      let(:user) { User.new name: "rob", job: "hexlet", gender: "m" }
      let(:form) do
        HexletCode.form_for user do |f|
          f.input :name
          f.input :job, as: :text
          f.input :gender, as: :select, collection: %w[m f]
        end
      end
      let(:form_html) do
        html = ""
        html += '<form action="#" method="post">'
        html += '<input type="text" value="rob" name="name">'
        html += '<textarea cols="20" rows="40" name="job">hexlet</textarea>'

        html += '<select name="gender">'
        html += '<option value="m" selected>m</option>'
        html += '<option value="f">f</option>'
        html += "</select>"

        html += "</form>"
        html
      end
      it "return correct form" do
        expect(form).to eq(form_html)
      end
    end
  end
end
