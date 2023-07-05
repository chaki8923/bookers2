require 'rails_helper'

RSpec.describe ChatsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  
  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    before do
      sign_in(user)
    end

    it 'assigns the chat, user, receiver_id, and chats' do
      create(:chat, sender: user, receiver: other_user)
      get :show, params: { id: other_user.id }
      expect(assigns(:chat)).to be_a_new(Chat)
      expect(assigns(:user)).to eq(user)
      expect(assigns(:receiver_id)).to eq(other_user.id.to_s)
      expect(assigns(:chats)).to eq(Chat.between(user.id, other_user.id.to_s))
    end

    it 'showテンプレートがレンダリングされること' do
      get :show, params: { id: other_user.id }
      expect(response).to render_template(:show)
    end
  end

  
  describe 'POST #create' do
    before { sign_in(user) }
    
    context '有効なパラメータの場合' do
      it 'チャットが作成され、リダイレクトすること' do
        expect do
          post :create, params: { chat: { message: 'Hello', receiver_id: other_user.id } }
        end.to change(Chat, :count).by(1)
        
        expect(response).to redirect_to(chat_path(other_user))
      end
    end
    
    context '無効なパラメータの場合' do
      it 'チャットが作成されず、indexテンプレートをレンダリングすること' do
        expect do
          post :create, params: { chat: { message: '', receiver_id: other_user.id } }
        end.not_to change(Chat, :count)
        
        expect(response).to render_template(:index)
      end
    end
  end
end
