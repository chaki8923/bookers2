require 'rails_helper'

RSpec.describe GroupUsersController, type: :controller do
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  before do
    sign_in user
  end
  
  describe "POST #join" do

    context "ユーザーが既にグループのメンバーである場合" do
       before do
        group.users << user
        post :join, params: { group_id: group.id, user_id: user.id }
      end
    
      it "ユーザーをグループに追加しないこと" do
        expect(response).to redirect_to(groups_path)
        expect(flash[:notice]).to eq("You are already a member of this group.")
        expect(group.users).to include(user)
      end
    
      it "フラッシュメッセージを設定すること" do
        expect(flash[:notice]).to eq("You are already a member of this group.")
      end

      it "グループ一覧ページにリダイレクトすること" do
        expect(response).to redirect_to(groups_path)
      end
    end

    context "ユーザーがグループのメンバーでない場合" do
      before do
         post :join, params: { group_id: group.id, user_id: user.id }
      end

      it "ユーザーをグループに追加すること" do
        expect(group.users).to include(user)
      end

      it "フラッシュメッセージを設定すること" do
        expect(flash[:notice]).to eq("You have joined the group successfully.")
      end

      it "グループ一覧ページにリダイレクトすること" do
        expect(response).to redirect_to(groups_path)
      end
    end
  end
end
