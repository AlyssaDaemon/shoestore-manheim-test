require_relative 'spec_helper'
require 'page-object'
require 'faker'

class FrontPage
  class << self; attr_accessor :base_url end
  include PageObject
  @base_url = "https://shoestore-manheim.rhcloud.com/"
  links(:nav_link, :css => "nav a")
  form(:email_subscription, id: "remind_email_form")
  div(:flash, :css => "div#flash > div.flash.notice")
end

class MonthPage < FrontPage
  @base_url = "https://shoestore-manheim.rhcloud.com/months"
  elements(:shoes, css: "ul#shoe_list > li" )
end

class AllShoesPage < MonthPage
  @base_url = "https://shoestore-manheim.rhcloud.com/shoes"
end