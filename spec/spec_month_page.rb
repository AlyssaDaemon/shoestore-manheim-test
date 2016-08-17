require_relative 'spec_page_object_helpers'
require 'date'


describe "Each MonthPage" do
  let(:browser) { @browser ||= Watir::Browser.new }
  let(:months) { @months ||= Date::MONTHNAMES.drop(1).length } #This represents the number of months (dropped one because the stdlib adds a nil)
  let(:front_page) { @front_page ||= FrontPage.new(browser)}
  before { browser.goto "https://shoestore-manheim.rhcloud.com/" }
  after { browser.close unless browser.nil? }

  it "should display a small blurb of each shoe" do
    months.times do |month|
      front_page.nav_link_elements[month].click
      @month_page = MonthPage.new(browser)
      @month_page.shoes_elements.each do |shoe|
        expect(shoe.td(:class => 'shoe_description').exists?).to be true
      end
    end
  end

  it "should display an image for each shoe to be released" do
    months.times do |month|
      front_page.nav_link_elements[month].click
      @month_page = MonthPage.new(browser)
      @month_page.shoes_elements.each do |shoe|
        expect(shoe.image.exist?).to be true
      end
    end
  end

  it "should have a suggested price" do
    months.times do |month|
      front_page.nav_link_elements[month].click
      @month_page = MonthPage.new(browser)
      @month_page.shoes_elements.each do |shoe|
        expect(shoe.td(:class => 'shoe_price').exists?).to be true
      end
    end
  end

  it "has a place to submit email address for reminder" do
    months.times do |month|
      front_page.nav_link_elements[month].click
      @month_page = MonthPage.new(browser)
      expect(@month_page.email_subscription_element.exists?).to be true
    end
  end

  it "accept shoe notifications if available" do
    months.times do |month|
      front_page.nav_link_elements[month].click
      @month_page = MonthPage.new(browser)
      @month_page.shoes_elements.each do |shoe|
        if shoe.form(:class => "notification_email_form").exists?
          @email = Faker::Internet.safe_email
          shoe.text_field.set @email
          shoe.input(:css => 'form.notification_email_form input[type="submit"]').click
          expect(@month_page.flash_element.text).to eq("Thanks! We will notify you when this shoe is available at this email: #{@email}")
        end
      end
    end
  end

  it "accepts input and returns the correct welcome message" do
    months.times do |month|
      @email = Faker::Internet.safe_email
      front_page.nav_link_elements[month].click
      @month_page = MonthPage.new(browser)
      @month_page.email_subscription_element.text_field.set @email
      @month_page.email_subscription_element.input(:css => 'input[type="submit"]').click
      expect(@month_page.flash_element.text).to eq("Thanks! We will notify you of our new shoes at this email: #{@email}")
    end
  end

end
