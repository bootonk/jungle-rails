require 'rails_helper'
require 'user.rb'

RSpec.describe User, type: :model do
  before do
    @user1 = User.create(:first_name => 'Bob', :last_name => 'Hopskins', :email => 'bob@gmail.com', :password => '12345678', :password_confirmation => '12345678')
  end
  
  describe 'Validations' do
    it 'should validate if all fields are valid' do
      expect(@user1).to be_valid
    end

    it 'should not validate if the password and confirmation password do not match' do
      user = User.create(:first_name => 'Bob', :last_name => 'Hopskins', :email => 'bob@gmail.com', :password => '12345678', :password_confirmation => '12356789')

      expect(user.password).to_not eq(user.password_confirmation)
      expect(user).to_not be_valid
    end

    it 'should not validate if the email already exists in the database' do
      user2 = User.create(:first_name => 'Robert', :last_name => 'Hopskins', :email => 'BOB@gmail.com', :password => '12345678', :password_confirmation => '12345678')

      expect(user2).to_not be_valid
    end

    it 'should not validate if first name is missing' do
      user = User.create(:first_name => nil, :last_name => 'Hopskins', :email => 'BOB@gmail.com', :password => '12345678', :password_confirmation => '12345678')

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should not validate if last name is missing' do
      user = User.create(:first_name => 'Bob', :last_name => nil, :email => 'BOB@gmail.com', :password => '12345678', :password_confirmation => '12345678')

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should not validate if the email address is missing' do
      user = User.create(:first_name => 'Bob', :last_name => 'Hopskins', :email => nil, :password => '12345678', :password_confirmation => '12345678')

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should not validate if the passowrd is under the minimum required length' do
      user = User.create(:first_name => 'Bob', :last_name => 'Hopskins', :email => 'rob@gmail.com', :password => '1234567', :password_confirmation => '1234567')

      expect(user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate a user if the email and password is valid' do
      user = User.authenticate_with_credentials(@user1.email, @user1.password)

      expect(user).to eq(@user1)
    end

    it 'should not authenticate a user if the password is incorrect' do
      user = User.authenticate_with_credentials(@user1.email, 'fail')

      expect(user).to be_nil
    end

    it 'should not authenticate a user if the email is incorrect' do
      user = User.authenticate_with_credentials('fail', @user1.password )

      expect(user).to be_nil
    end

    it 'should authenticate if there are spaces before and/or after the submitted email' do
      user = User.authenticate_with_credentials('  bob@gmail.com  ', @user1.password )

      expect(user).to eq(@user1)
    end

    it 'should authenticate with an email regardless of the case submitted' do
      user = User.authenticate_with_credentials('BoB@GmAil.COM', @user1.password )

      expect(user).to eq(@user1)
    end
  end

end
