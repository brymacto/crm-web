require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'
@@crm_app_name = "BoomCRM"
@@year = Time.now.year
@@rolodex = Rolodex.new

def get_crm_count
  @@crm_count = @@rolodex.contacts.length
end

get_crm_count

def get_prev_contact_id(current_id)
  @prev_contact = @@rolodex.find(current_id).id - 1
  if @@rolodex.find(@prev_contact)
    @@rolodex.find(@prev_contact).id
  else
    @@rolodex.find_by_element_id(@@rolodex.length - 1).id
  end
end

def get_next_contact_id(current_id)

# Look up index of ID in contacts array.
# Return ID of next array element (index+1)

@@rolodex.contacts.each_with_index do |contact, index|
  contact_id = contact.id
    if contact_id.to_i == (current_id).to_i
      return @@rolodex.contacts[index + 1].id
    end
  end
  return @@rolodex.find_id_by_index(0)
end

get '/' do
  @page_name = "Home"
  erb :index
  redirect to("/contacts")
end

get "/contacts" do
  @page_name = "View all contacts"
  @notification = params[:notification]
  @notification_id = params[:notification_id]
  erb :contacts
end

get '/contacts/new' do
  @page_name = "Add new contact"
  erb :new_contact
end

post '/contacts' do
  new_id = (@@rolodex.add_contact(params[:first_name], params[:last_name], params[:email], params[:notes]) - 1)
  get_crm_count

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
    redirect to("/contacts?notification=edited&notification_id=#{@contact.id}")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @@rolodex.remove_contact(@contact)
    get_crm_count
    redirect to("/contacts?notification=deleted&notification_id=#{@contact.id}")
  else
    raise Sinatra::NotFound
  end
end