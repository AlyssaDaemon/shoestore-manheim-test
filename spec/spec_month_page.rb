require 'watir'
require 'page-object'
require_relative 'spec_helper'
require 'date'


describe "Each Month" do
  let(:browser) { @browser ||= Watir::Browser.new }
  let!(:shoes) { @shoes ||= Array.new }
  let(:months) { Date::MONTHNAMES.drop(2).length } #This represents the number of months (dropped two because the stdlib adds a nil)
  before { browser.goto "https://shoestore-manheim.rhcloud.com/" }
  after { browser.close unless browser.nil? }

  class MonthPage
    include PageObject
    elements(:shoes, css: "ul#shoe_list > li")
  end

  it "should display a small blurb of each shoe" do
    months.times do |month|
      browser.links(css: "nav > ul > li > a")[month].click
      @month_page = MonthPage.new(browser)
      @month_page.shoes_elements.each do |shoe|
        expect(shoe.td(:class => 'shoe_description').exists?).to be true
      end
    end
  end

  it "should display an image for each shoe to be released" do
    months.times do |month|
      browser.links(css: "nav > ul > li > a")[month].click
      @month_page = MonthPage.new(browser)
      @month_page.shoes_elements.each do |shoe|
        expect(shoe.image.exist?).to be true
      end
    end
  end
end
