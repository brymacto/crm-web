require 'sinatra'
require 'data_mapper'
DataMapper.setup(:default, "sqlite3:database.sqlite3")
@@crm_app_name = "BoomCRM"
@@year = Time.now.year

class Contact
  include DataMapper::Resource
  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

def get_search_results(search_string)
  Contact.all(:first_name.like => search_string) | Contact.all(:last_name.like => search_string)
end

def get_crm_count
  @@crm_count = Contact.count
end
get_crm_count

def get_prev_contact_id(current_contact_id)
  if Contact.last({:id.lt => current_contact_id})
    Contact.last({:id.lt => current_contact_id}).id
  else
    Contact.last({}).id
  end
end

def get_next_contact_id(current_contact_id)
  if Contact.first({:id.gt => current_contact_id})
    Contact.first({:id.gt => current_contact_id}).id
  else
    Contact.first({}).id
  end
end

get '/' do
  @page_name = "Home"
  erb :index
  redirect to("/contacts")
end

get "/search" do
  @search_string = params[:search_string]
  @page_name = "Search results"
  erb:search

end

get "/contacts" do
  @page_name = "View all contacts"
  @notification = params[:notification]
  @notification_id = params[:notification_id]
  @contacts = Contact.all
  erb :contacts
end

get '/contacts/new' do
  @page_name = "Add new contact"
  erb :new_contact
end

post '/contacts' do
  puts "in post /contacts"
    contact = Contact.create(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :note => params[:note]
  )
  new_id = contact.id
  get_crm_count
  redirect to("/contacts?notification=added&notification_id=#{new_id}")
end

get "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  @page_name = "View contact: #{@contact.first_name} #{@contact.last_name}"
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/edit" do
  @contact = Contact.get(params[:id].to_i)
  @page_name = "Edit contact: #{@contact.first_name} #{@contact.last_name}"
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
  @contact.update(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :note => params[:note]
  )
    redirect to("/contacts?notification=edited&notification_id=#{@contact.id}")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.destroy
    # @@rolodex.remove_contact(@contact)
    get_crm_count
    redirect to("/contacts?notification=deleted&notification_id=#{:id}")
  else
    raise Sinatra::NotFound
  end
end