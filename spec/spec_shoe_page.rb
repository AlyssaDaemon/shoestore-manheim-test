require_relative 'spec_page_object_helpers'

describe "AllShoesPage" do
  let(:browser) { @browser ||= Watir::Browser.new }
  before { browser.goto "https://shoestore-manheim.rhcloud.com/shoes" }
  after { browser.close unless browser.nil? }

  it "should display a small blurb for each shoe" do
    @shoes = AllShoesPage.new browser
    @shoes.shoes_elements.each do |shoe|
      expect(shoe.td(:class => 'shoe_description').exists?).to be true
    end
  end

  it "should display an image for each shoe to be released" do
    @shoes = AllShoesPage.new browser
    @shoes.shoes_elements.each do |shoe|
        expect(shoe.image.exist?).to be true
    end
  end

  it "should have a suggested price" do
    @shoes = AllShoesPage.new browser
    #Making shoes a let causes an infinate stack error
    @shoes.shoes_elements.each do |shoe|
      expect(shoe.td(:class => 'shoe_price').exists?).to be true
    end
  end

  it "has a place to submit email address for reminder" do
    @shoes = AllShoesPage.new browser
    expect(@shoes.email_subscription_element.exists?).to be true
  end

  it "accepts shoe notifications if available" do
    @shoes = AllShoesPage.new browser
    @shoes.shoes_elements.each do |shoe|
      if shoe.form(:class => "notification_email_form").exists?
        @email = Faker::Internet.safe_email
        shoe.text_field.set @email
        shoe.input(:css => 'form.notification_email_form input[type="submit"]').click
        expect(@shoes.flash_element.text).to eq("Thanks! We will notify you when this shoe is available at this email: #{@email}")
      end
    end
  end


  it "accepts input and returns the correct welcome message" do
    @shoes = AllShoesPage.new browser
    @email = Faker::Internet.safe_email
    @shoes.email_subscription_element.text_field.set @email
    @shoes.email_subscription_element.input(:css => 'input[type="submit"]').click
    expect(@shoes.flash_element.text).to eq("Thanks! We will notify you of our new shoes at this email: #{@email}")
  end

end