# frozen_string_literal: true

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
  end
end
