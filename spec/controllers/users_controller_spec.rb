require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  before do
    sign_in user
  end
  describe 'GET show' do
    it '正常なレスポンスを返すこと' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end

    it '対象のユーザー情報を表示すること' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'ユーザーの投稿を表示すること' do
      book1 = FactoryBot.create(:book, user: user)
      book2 = FactoryBot.create(:book, user: user)
      get :show, params: { id: user.id }
      expect(assigns(:books)).to eq([book1, book2])
    end

    it '新しい投稿のインスタンスを作成すること' do
      get :show, params: { id: user.id }
      expect(assigns(:book)).to be_a_new(Book)
    end
  end

  describe 'GET index' do
    it '正常なレスポンスを返すこと' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it '全てのユーザーを取得すること' do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      get :index
      expect(assigns(:users)).to include(user1, user2)
    end

    it '新しい投稿のインスタンスを作成すること' do
      get :index
      expect(assigns(:book)).to be_a_new(Book)
    end
  end

  describe 'GET edit' do
    context 'ログインユーザーが対象のユーザーの場合' do
      before { sign_in user }

      it '正常なレスポンスを返すこと' do
        get :edit, params: { id: user.id }
        expect(response).to have_http_status(:success)
      end

      it '対象のユーザーを取得すること' do
        get :edit, params: { id: user.id }
        expect(assigns(:user)).to eq(user)
      end
    end

    context 'ログインユーザーが対象のユーザーではない場合' do
      before { sign_in user }

     it 'ユーザーページにリダイレクトされること' do
        user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user) # ログインユーザーとは別のユーザーを作成
        sign_in user
      
        get :edit, params: { id: other_user.id }
      
        expect(response).to redirect_to(user_path(user))
      end
    end
  end

  describe 'PATCH update' do
    context 'ログインユーザーが対象のユーザーの場合' do
      before { sign_in user }
    end

      context '正しいパラメータが渡された場合' do
        it 'ユーザー情報を更新' do
          valid_params = { name: 'New Name' }
          patch :update, params: { id: user.id, user: valid_params }
          expect(response).to redirect_to(user_path(user))
        end
      end
    end
      
  describe 'GET search_count' do
  it '正常なレスポンスを返すこと' do
   get :search_count, params: { id: user.id, date: Date.today }, format: :js, xhr: true
    expect(response).to have_http_status(:success)
  end
  
  it '対象のユーザーを取得すること' do
    get :search_count, params: { id: user.id, date: Date.today }, format: :js, xhr: true
    expect(assigns(:user)).to eq(user)
  end

  it '指定した日付の投稿数を取得すること' do
    FactoryBot.create(:book, user: user, created_at: Date.today)
    FactoryBot.create(:book, user: user, created_at: Date.today)
    FactoryBot.create(:book, user: user, created_at: Date.yesterday)
    get :search_count, params: { id: user.id, date: Date.today }, format: :js, xhr: true
    expect(assigns(:dat_of_count)).to eq(2)
  end
 end
end