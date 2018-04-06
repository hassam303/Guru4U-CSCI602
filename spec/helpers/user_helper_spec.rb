require 'rails_helper'

describe UsersHelper do
    describe 'create user account'  do
        it 'calls the model method for creating the user account' do
            response = 
                User.create_user(
                    {name: "Test User", 
                     email: "testuser@gmail.com", 
                     phone_number: "8435551234", 
                     password: "foobar", 
                     password_confirmation: "foobar", 
                     admin: true})
            expect(response[1]).to be_nil
        end
    end
end