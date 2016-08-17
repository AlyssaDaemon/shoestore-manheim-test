require 'page-object'
require 'watir'
require_relative 'spec_helper'

describe "Each Shoe" do
  let(:browser) { @browser ||= Watir::Browser.new }
  before { browser.goto "https://shoestore-manheim.rhcloud.com/shoes" }
  after { browser.close unless browser.nil? }

  class ShoesPage
    include PageObject
    elements(:shoes, css: "ul#shoe_list > li")
  end

  it "should have a suggested price" do
    shoes = ShoesPage.new(browser)
    shoes.shoes_elements.each do |shoe|
      expect(shoe.td(:class => 'shoe_price').exists?).to be true
    end
  end

end