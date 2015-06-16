require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'
crm_app_name = "Bryan's CRM"

$rolodex = Rolodex.new

get '/' do
  @crm_app_name = crm_app_name
  erb :index
end

get "/contacts" do
  @crm_app_name = crm_app_name
  erb :contacts
end

get '/contacts/new' do
  erb :new_contact
end

post '/contacts' do
  $rolodex.add_contact(params[:first_name], params[:last_name], params[:email], params[:note])
  redirect to('/contacts')
end