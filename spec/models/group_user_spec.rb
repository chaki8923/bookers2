require 'rails_helper'
RSpec.describe GroupUser, type: :model do
  describe 'associations' do
    let(:user) { create(:user) }
    let(:group) { create(:group) }
    let!(:group_user) { create(:group_user, user: user, group: group) }

    it 'belongs to user' do
      expect(GroupUser.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'belongs to group' do
      expect(GroupUser.reflect_on_association(:group).macro).to eq(:belongs_to)
    end
  end
end