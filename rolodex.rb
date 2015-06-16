require_relative('contact.rb')

class Rolodex
  @@id = 1000

  attr_reader :id

  def add_fake_contacts!
    add_contact("Yehuda", "Katz", "yehuda@example.com", "Developer")
    add_contact("Mark", "Zuckerberg", "mark@facebook.com", "CEO")
    add_contact("Sergey", "Brin", "sergey@google.com", "Co-Founder")
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

  def all
    @contacts
  end
end