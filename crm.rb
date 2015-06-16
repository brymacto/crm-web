

require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'
$crm_app_name = "BJM CRM"

@@rolodex = Rolodex.new
get '/' do
  erb :index
end

get "/contacts" do
  erb :contacts
end

get '/contacts/new' do
  erb :new_contact
end

post '/contacts' do
  @@rolodex.add_contact(params[:first_name], params[:last_name], params[:email], params[:note])
  redirect to('/contacts')
end

get "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  erb :show_contact
end