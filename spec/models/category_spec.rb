require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :name }
  end
  
  describe 'Validation' do
    it { is_expected.to validate_presence_of :name }
  end
end
