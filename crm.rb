require_relative('contact')
require_relative('rolodex')

class CRM
  def self.run(name)
    crm = CRM.new(name)
    crm.main_menu
  end

  def initialize(name)
    @name = name
    @rolodex = Rolodex.new
  end

  def name
    @name
  end

  def main_menu
    print_main_menu
    user_selected = gets.to_i
    call_option(user_selected)
  end

  def print_main_menu
    # if @rolodex.contacts[0]
    #   puts @rolodex.contacts[0].first_name
    # end

    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Display all the contacts"
    puts "[5] Display an attribute"
    puts "[6] Exit"
    puts "Enter a number: "
  end

  def call_option(user_selected)
    add_new_contact if user_selected == 1
    modify_existing_contact if user_selected == 2
    delete_existing_contact if user_selected == 3
    display_all_contacts if user_selected == 4
    display_an_attribute if user_selected == 5


    # Finish off and do the rest for 3 through 6
    # To be clear, the methods add_new_contact and modify_existing_contact
    # haven't been defined yet
  end

  def add_new_contact
    print "Enter First Name: "
    first_name = gets.chomp
    print "Enter Last Name: "
    last_name = gets.chomp
    print "Enter Email Address: "
    email = gets.chomp
    print "Enter a Note: "
    note = gets.chomp
    contact = Contact.new(first_name, last_name, email, note)
    @rolodex.add_contact(contact)

    main_menu
  end

  def modify_existing_contact
    contact = get_contact("modify")

    print "Which attribute would you like to modify? "
    attribute = gets.chomp

    if attribute == "first name"
      print "Enter new first name: "
      first_name = gets.chomp
      contact.first_name = first_name
    elsif attribute == "last name"
      print "Enter new last name: "
      last_name = gets.chomp
      contact.last_name = last_name
    elsif attribute == "email"
      print "Enter new email: "
      email = gets.chomp
      contact.email = email
    end

    puts "Updated #{contact.email}'s information."

    main_menu
  end

  def delete_existing_contact
    contact = get_contact("delete")

    puts "Are you sure? (y/n)"
    answer = gets.chomp

    if answer == "y"
      deleted_contact = @rolodex.contacts.delete(contact)

      puts "Deleted #{deleted_contact.email}'s information."
    else
    end

    main_menu
  end
  def display_all_contacts
    @rolodex.contacts.each do |contact|
      puts "Contact #{contact.id}'s information"
      puts contact.first_name
      puts contact.last_name
    end
  end

  def display_an_attribute
    contact = get_contact("see")

    print "Which attribute would you like to see? "
    attribute = gets.chomp

    if attribute == "first name"
      puts contact.first_name
    elsif attribute == "last name"
      puts contact.last_name
    end

    main_menu
  end

  def get_contact(verb)
    print "Enter the email of the person you want to #{verb}: "
    email = gets.chomp

    @rolodex.find(email)
  end


end

CRM.run("Bitmaker Labs CRM")
