require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :name }
  end
  
  describe 'Validation' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'Association' do
    it { is_expected.to have_many :articles }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:category)).to be_valid
    end
  end
end