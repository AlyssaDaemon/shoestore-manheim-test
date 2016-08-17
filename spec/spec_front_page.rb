require_relative 'spec_page_object_helpers'

describe "FrontPage" do
  let(:email) { @email ||= Faker::Internet.safe_email }
  let(:browser) { @browser ||= Watir::Browser.new }
  let(:front_page) { @front_page ||= FrontPage.new(browser)}
  before { browser.goto "https://shoestore-manheim.rhcloud.com/" }
  after  { browser.close }

  it "has a place to submit email address for reminder" do
    expect(front_page.email_subscription_element.exists?).to be true
  end

  it "accepts input and returns the correct welcome message" do
    front_page.email_subscription_element.text_field(:id => "remind_email_input").set email
    front_page.email_subscription_element.input(:css => 'input[type="submit"]').click

    expect(front_page.flash_element.text).to eq("Thanks! We will notify you of our new shoes at this email: #{email}")

  end



end