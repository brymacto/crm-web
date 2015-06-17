

require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'
@@crm_app_name = "BJM CRM"
@@year = Time.now.year


@@rolodex = Rolodex.new

def get_crm_count
  @@crm_count = @@rolodex.contacts.length
end

get_crm_count
puts "crm count: #{@@crm_count}"

get '/' do
  @page_name = "Home"
  erb :index
end

get "/contacts" do
  @page_name = "View all contacts"
  erb :contacts
end

get '/contacts/new' do
  @page_name = "Add new contact"
  erb :new_contact
end

post '/contacts' do
  @@rolodex.add_contact(params[:first_name], params[:last_name], params[:email], params[:notes])
  get_crm_count
  redirect to('/contacts')
end


get "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  @page_name = "View contact: #{@contact.first_name} #{@contact.last_name}"
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/edit" do
  @contact = @@rolodex.find(params[:id].to_i)
  @page_name = "Edit contact: #{@contact.first_name} #{@contact.last_name}"
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.notes = params[:notes]
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @@rolodex.remove_contact(@contact)
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end
