class Contact < ApplicationRecord
    validates_presence_of :last_name
    validates_presence_of :first_name
    validates_presence_of :email
    validates_presence_of :phone
    validate :uniqueness_of_email

    def uniqueness_of_email
        existing_record = Contact.find_by_email(email)
        if !existing_record.nil? && existing_record.id != id
            errors.add(:email, "Email has already been taken")
        end
    end
end
