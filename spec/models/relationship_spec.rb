require 'rails_helper'
RSpec.describe Relationship, type: :model do
  describe 'associations' do
    let(:follower) { create(:user) }
    let(:followed) { create(:user) }

    it 'belongs to follower' do
      association = described_class.reflect_on_association(:follower)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('User')
      expect(association.foreign_key).to eq('follower_id')
    end

    it 'belongs to followed' do
      association = described_class.reflect_on_association(:followed)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('User')
      expect(association.foreign_key).to eq('followed_id')
    end
  end

  describe 'validations' do
    it 'validates presence of follower_id' do
      relationship = Relationship.new(followed_id: 1)
      expect(relationship).not_to be_valid
      expect(relationship.errors[:follower_id]).to include("can't be blank")
    end

    it 'validates presence of followed_id' do
      relationship = Relationship.new(follower_id: 1)
      expect(relationship).not_to be_valid
      expect(relationship.errors[:followed_id]).to include("can't be blank")
    end
  end
end
