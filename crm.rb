require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

crm_app_name = "Bryan's CRM"

get '/' do
  @crm_app_name = crm_app_name
  erb :index
end

get 'style.css' do

  end

get "/contacts" do
  @crm_app_name = crm_app_name
  @contacts = []
  @contacts << Contact.new("Yehuda", "Katz", "yehuda@example.com", "Developer")
  @contacts << Contact.new("Mark", "Zuckerberg", "mark@facebook.com", "CEO")
  @contacts << Contact.new("Sergey", "Brin", "sergey@google.com", "Co-Founder")
  erb :contacts
end

