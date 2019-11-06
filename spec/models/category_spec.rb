require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :category }
    it { is_expected.to have_db_column :article_id }
  end
  
  describe 'Validation' do
    it { is_expected.to validate_presence_of :category }
    it { is_expected.to validate_presence_of :article_id }
  end
end
