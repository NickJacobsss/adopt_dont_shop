class Application < ApplicationRecord
   validates_presence_of :name,
                         :address,
                         :city,
                         :state,
                         :zipcode,
                         :description,
                         :status

   has_many :pet_applications
   has_many :pets, through: :pet_applications

   def all_approved?
     self.pet_applications.all? do |pet_apps|
       pet_apps.status == 'Approved'
     end
   end

   def all_updated?
     self.pet_applications.all? do |pet_apps|
       pet_apps.status == 'Approved' || pet_apps.status == 'Rejected'
     end
   end

   def no_longer_adoptable
     self.pets.each do |pet|
       pet.adoptable = false
       pet.save
     end
   end
 end
