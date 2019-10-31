# RSpec.describe 'Journalist can edit their article' do
#   describe 'things happen successfully' do
#     let!(:article) {create(:article)}
#     let(:headers) { { HTTP_ACCEPT: 'application/json' } }

#     describe 'user roles are permitted'
#     permit_action(:visitor).to eq true
#   end
# end

# require 'rails_helper'

# describe ArticlePolicy do
#   subject { described_class.new(user, article) }

#   let(:article) { Article.create }

#   context 'being a visitor' do
#     let(:user) { nil }

#     it { is_expected.to permit_action(:show) }
#     it { is_expected.to forbid_action(:destroy) }
#   end

#   context 'being an administrator' do
#     let(:user) { User.create(administrator: true) }

#     it { is_expected.to permit_actions([:show, :destroy]) }
#   end
# end