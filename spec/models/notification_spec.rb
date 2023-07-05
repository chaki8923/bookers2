require 'rails_helper'
RSpec.describe Notification, type: :model do
  describe 'associations' do
    let(:group) { create(:group) }

    it 'belongs to group' do
      association = described_class.reflect_on_association(:group)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('Group')
    end
  end

  describe 'validations' do
    it 'validates presence of title' do
      notification = Notification.new(body: 'Lorem ipsum')
      expect(notification).not_to be_valid
      expect(notification.errors[:title]).to include("can't be blank")
    end

    it 'validates presence of body' do
      notification = Notification.new(title: 'Lorem ipsum')
      expect(notification).not_to be_valid
      expect(notification.errors[:body]).to include("can't be blank")
    end

    it 'validates maximum length of body' do
      notification = Notification.new(title: 'Lorem ipsum', body: 'a' * 201)
      expect(notification).not_to be_valid
      expect(notification.errors[:body]).to include("is too long (maximum is 200 characters)")
    end
  end
end
