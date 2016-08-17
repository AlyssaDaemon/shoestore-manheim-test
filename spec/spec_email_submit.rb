require 'spec_helper'
require 'watir'
require 'faker'

describe "User email address submittion" do
  let(:email) { @email ||= Faker::Internet.safe_email }
  let(:browser) { @browser ||= Watir::Browser.new }
  before { browser.goto "https://shoestore-manheim.rhcloud.com/" }
  after  { browser.close }

  it "has a place to submit email adress for reminder" do
    expect(browser.input(:id => "remind_email_input").exists?).to be true
  end

  it "accepts input and returns the correct welcome message" do
    @form = browser.form(:id => "remind_email_form")
    @form.text_field(:id => "remind_email_input").set email
    @form.input(:css => 'input[type="submit"]').click

    expect(browser.div(:css => "div#flash > div.flash.notice").text).to eq("Thanks! We will notify you of our new shoes at this email: #{email}")

  end



end