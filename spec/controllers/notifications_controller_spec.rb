require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group, owner_id: user.id) }
  let(:notification_params) { attributes_for(:notification, group_id: group.id) }

  before do
    sign_in(user)
  end

  describe 'GET #new' do
    context '存在するグループの場合' do
      before do
        get :new, params: { id: group.id }
      end

      it '新しい通知を割り当てること' do
        expect(assigns(:notification)).to be_a_new(Notification)
      end

      it 'newテンプレートをレンダリングすること' do
        expect(response).to render_template(:new)
      end
    end

    context '存在しないグループの場合' do
      before do
        get :new, params: { id: 9999 } # 存在しないグループのIDを指定
      end

      it 'groups_pathにリダイレクトすること' do
        expect(response).to redirect_to(groups_path)
      end

      it '適切なフラッシュメッセージが表示されること' do
        expect(flash[:notice]).to eq('Group is Not Found.')
      end
    end

    context 'グループのオーナーでない場合' do
      let(:other_user) { create(:user) }
      let(:other_group) { create(:group, owner_id: other_user.id) }

      before do
        get :new, params: { id: other_group.id }
      end

      it 'groups_pathにリダイレクトすること' do
        expect(response).to redirect_to(groups_path)
      end

      it '適切なフラッシュメッセージが表示されること' do
        expect(flash[:notice]).to eq('Oh! You hane No Authority.')
      end
    end
  end

  describe 'POST #create' do
    context '有効なパラメーターの場合' do
      it '新しい通知を作成すること' do
        expect {
          post :create, params: { notification: notification_params }
        }.to change(Notification, :count).by(1)
      end

      it 'notifications_completed_pathにリダイレクトすること' do
        post :create, params: { notification: notification_params }
        expect(response).to redirect_to(notifications_completed_path(id: Notification.last.id))
      end
    end

    context '無効なパラメーターの場合' do
      let(:invalid_params) { { notification: { title: '', body: '', group_id: group.id } } }

      it '新しい通知を作成しないこと' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Notification, :count)
      end

      it 'newテンプレートをレンダリングすること' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end
        
  describe 'GET #completed' do
    let(:notification) { create(:notification) }
    before do
     get :completed, params: { id: notification.id }
    end

    it '指定した通知を割り当てること' do
      expect(assigns(:notification)).to eq(notification)
    end
    
    it 'completedテンプレートをレンダリングすること' do
      expect(response).to render_template(:completed)
    end
  end
end

