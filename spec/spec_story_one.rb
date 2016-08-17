
require 'spec_helper'
require 'date'


describe "Each shoe" do
  #Lets are not allowed to be referenced in a before :all, so this exists
  def shoes
    @shoes ||= Array.new
  end

  #Set to before :all as we can gather all the information we need in one fell swoop.
  before :all do
    browser = Watir::Browser.new
    #Date::MONTHNAMES.drop(1) is a lazy and cheap way to get all the english month names
    Date::MONTHNAMES.drop(1).each do |month|
      browser.goto "http://shoestore-manheim.rhcloud.com/months/#{month}"
      browser.elements(:css => 'ul#shoe_list > li').each do |s|
        shoes << { :description => s.td(:class => 'shoe_description').exists?, :img => s.img.exists?, :price => s.td(:class => "shoe_price").exists? }
      end
    end
  end
  after { browser.close }

  it "should display a small blurb of each shoe" do
    shoes.each do |shoe|
      expect(shoe[:description]).to be true
    end
  end

  it "should display an image of each shoe" do
    shoes.each do |shoe|
      expect(shoe[:img]).to be true
    end
  end

  it "should display a suggested price" do
    shoes.each do |shoe|
      expect(shoe[:price]).to be true
    end
  end

end