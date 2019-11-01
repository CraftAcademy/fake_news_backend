require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should have valid Factory' do
    expect(create(:user)).to be_valid
  end

  describe 'Database table' do
    it { is_expected.to have_db_column :uid }
    it { is_expected.to have_db_column :encrypted_password }
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :tokens }
    it { is_expected.to have_db_column :role }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_confirmation_of(:password) }

    context 'should not have an invalid email address' do
      emails = ['asdf@ ds.com', '@example.com', 'test me @yahoo.com',
                'asdf@example', 'ddd@.d. .d', 'ddd@.d']

      emails.each do |email|
        it { is_expected.not_to allow_value(email).for(:email) }
      end
    end

    context 'should have a valid email address' do
      emails = ['asdf@ds.com', 'hello@example.uk', 'test1234@yahoo.si',
                'asdf@example.eu']

      emails.each do |email|
        it { is_expected.to allow_value(email).for(:email) }
      end
    end
  end
end