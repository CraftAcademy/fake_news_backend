RSpec.describe 'Journalist can edit their article' do
  describe 'return article successfully' do
    let!(:article) {create(:article)}
    let(:headers) { { HTTP_ACCEPT: 'application/json' } }

    # test for role (Author?)
    # Test login and can create article