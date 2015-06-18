require_relative('contact.rb')

class Rolodex
  @@id = 1000

  attr_reader :id
  def length
    @contacts.length
  end
  def add_fake_contacts!
    add_contact("Fernando", "Muslera", "fernandomuslera@gmail.com", "GK")
    add_contact("Rodrigo", "Muñoz", "rod_munoz@hotmail.com", "GK")
    add_contact("Martín", "Silva", "silvamar@gmail.com", "GK")
    add_contact("Carlos", "Sánchez", "c_sanchez@ymail.com", "MF")
    add_contact("Cristian", "Rodríguez", "rodriguezcristian@gmail.com", "MF")
    add_contact("Giorgian", "De Arrascaeta", "giorgiandea@gmail.com", "MF")
    add_contact("Nicolás", "Lodeiro", "thenicolas@hotmail.com", "MF")
    add_contact("Guzmán", "Pereira", "periera1991@gmail.com", "MF")
    add_contact("Egidio", "Arévalo Ríos", "egiegidio@gmail.com", "MF")
    add_contact("Álvaro", "González", "alvgonza@gmail.com", "DF")
    add_contact("José", "Giménez", "joseg@gmail.com", "DF")
    add_contact("Diego", "Godín", "mr_godin@yahoo.com", "DF")
    add_contact("Jorge", "Fucile", "fucile_jorge@hotmail.com", "DF")
    add_contact("Álvaro", "Periera", "aperiera@gmail.com", "DF")
    add_contact("Gastón", "Silva", "bigsilva@yahoo.com", "DF")
    add_contact("Mathías", "Corujo", "corujom@gmail.com", "DF")
    add_contact("Maxi", "Pereira", "maximaxip@gmail.com", "DF")
    add_contact("Sebastián", "Coates", "theseb1990@gmail.com", "DF")

  end

  def initialize
    @contacts = []
    add_fake_contacts!
  end

  def contacts
    @contacts
  end

  def add_contact(first_name, last_name, email, notes)
    contact = Contact.new(@@id, first_name, last_name, email, notes)
    @contacts << contact
    @@id += 1
  end

  def remove_contact(contact)
    @contacts.delete(contact)
    @contacts.reject! { |contact| contact == nil }
  end

  def find(contact_id)
    @contacts.find {|contact| contact.id == contact_id }
  end

  def find_by_element_id(element_id)
    @contacts[element_id]
  end


  def all
    @contacts
  end
end