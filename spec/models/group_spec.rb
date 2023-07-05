require 'rails_helper'
RSpec.describe Group, type: :model do
  describe 'associations' do
    it 'has many group_users' do
      association = described_class.reflect_on_association(:group_users)
      expect(association.macro).to eq(:has_many)
    end

  end
  
  describe 'attachments' do
    it 'has one attached image' do
      expect(subject).to respond_to(:image)
      expect(subject.image).to be_an_instance_of(ActiveStorage::Attached::One)
    end
  end
end
