require_relative 'contact'
require 'sinatra'

crm_app_name = "Bryan's CRM"

get '/' do
  @crm_app_name = crm_app_name
  erb :index
end

get '/contacts' do
  @crm_app_name = crm_app_name
  erb :contacts
end