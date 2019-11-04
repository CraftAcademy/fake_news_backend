describe ArticlePolicy do

  let(:article) { create(:article) }

  context 'Visitor can access index of articles' do
    subject { described_class.new(user, article) }
    let(:user) { nil }

    it { is_expected.to permit_actions [:index] }
    it { is_expected.to forbid_actions [:create, :update, :show] }
  end

  context 'Registered user can not create a new article' do
    subject { described_class.new(user, article) }
    let(:user) { create(:user) }
    
    it { is_expected.to forbid_actions [:create, :update] }
  end

  context 'Registered user with subscription cannot edit or update an article' do
    subject { described_class.new(subscriber, article) }
    let(:subscriber) { create(:user, role: 'subscriber') }

    it { is_expected.to permit_actions [:index, :show] }
    it { is_expected.to forbid_actions [:create, :update] }
  end

  context 'Journalist can create and update articles' do
    subject { described_class.new(journalist, article) }
    let(:journalist) { create(:user, role: 'journalist') }
    let(:article) { create(:article, journalist: journalist) }

    it { is_expected.to permit_actions(%i[show index create update]) }
  end
end
