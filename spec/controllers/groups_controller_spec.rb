require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:user) { create(:user) }
  before do
    sign_in(user)
  end
  
  describe 'GET #new' do
    it '新しいグループと本を割り当てること' do
      get :new
      expect(assigns(:group)).to be_an_instance_of(Group)
      expect(assigns(:book)).to be_an_instance_of(Book)
    end

    it 'newテンプレートをレンダリングすること' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    let(:group) { create(:group) }

    it '指定したグループを割り当てること' do
      get :edit, params: { id: group.id }
      expect(assigns(:group)).to eq(group)
    end

    it 'editテンプレートをレンダリングすること' do
      get :edit, params: { id: group.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'GET #index' do
    it '全てのグループを割り当てること' do
      create_list(:group, 3)
      get :index
      expect(assigns(:groups)).to eq(Group.all)
    end

    it 'indexテンプレートをレンダリングすること' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let(:group) { create(:group) }

    it '指定したグループを割り当てること' do
      get :show, params: { id: group.id }
      expect(assigns(:group)).to eq(group)
    end

    it 'showテンプレートをレンダリングすること' do
      get :show, params: { id: group.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    let(:valid_params) { { group: attributes_for(:group) } }
    let(:invalid_params) { { group: { name: '' } } }

    context '有効なパラメーターの場合' do
      it '新しいグループを作成すること' do
        expect {
          post :create, params: { group: { name: "Group Name", introduction: "Group Introduction", owner_id: user.id } }
        }.to change(Group, :count).by(1)
      end

      it 'groups_pathにリダイレクトすること' do
        post :create, params: { group: { name: "Group Name", introduction: "Group Introduction", owner_id: user.id } }
        expect(response).to redirect_to(groups_path)
      end

      it 'フラッシュメッセージを設定すること' do
        post :create, params: { group: { name: "Group Name", introduction: "Group Introduction", owner_id: user.id } }
        expect(flash[:notice]).to eq('You have created group successfully.')
      end
    end

end

describe 'PATCH #update' do
let(:group) { create(:group) }
let(:valid_params) { { id: group.id, group: { name: 'Updated Name' } } }
let(:invalid_params) { { id: group.id, group: { name: '' } } }
context '有効なパラメーターの場合' do
  it '指定したグループを更新すること' do
    patch :update, params: valid_params
    group.reload
    expect(group.name).to eq('Updated Name')
  end

  it 'groups_pathにリダイレクトすること' do
    patch :update, params: valid_params
    expect(response).to redirect_to(groups_path)
  end

  it 'フラッシュメッセージを設定すること' do
    patch :update, params: valid_params
    expect(flash[:notice]).to eq('You have updated group successfully.')
  end
end
end

describe 'DELETE #destroy' do
let!(:group) { create(:group) }

it '指定したグループを削除すること' do
  expect {
    delete :destroy, params: { id: group.id }
  }.to change(Group, :count).by(-1)
end

it 'groups_pathにリダイレクトすること' do
  delete :destroy, params: { id: group.id }
  expect(response).to redirect_to(groups_path)
end

it 'フラッシュメッセージを設定すること' do
  delete :destroy, params: { id: group.id }
  expect(flash[:notice]).to eq('You have delete group successfully.')
end
end
end

