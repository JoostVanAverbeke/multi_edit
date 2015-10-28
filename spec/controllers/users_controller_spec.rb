require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'PATCH #update_all users' do

    let (:user1) { FactoryGirl.create(:user) }
    let (:user2) { FactoryGirl.create(:user, first_name: 'Lara') }
    let (:user3) { FactoryGirl.create(:user) }

    describe "valid attributes" do
      before(:each) do
        # patch :update_all, user: FactoryGirl.attributes_for(:user)
        put :update_all, :user => {
                           user1.to_param => FactoryGirl.attributes_for(:user, first_name: 'Joost'),
                           user2.to_param => FactoryGirl.attributes_for(:user, first_name: 'Sofia'),
                           user3.to_param => FactoryGirl.attributes_for(:user)
                       }
      end

      it "changes the users attributes if they were updated" do
        user1.reload
        user2.reload
        user3.reload
        expect(user1.first_name).to eq('Joost')
        expect(user2.first_name).to eq('Sofia')
        expect(user3.first_name).to eq('John')
      end

      it "redirects to the index view (list of users)" do
        expect(response).to redirect_to users_url
      end

    end

    describe "invalid attributes" do
      before(:each) do
        put :update_all, :user => {
                           user1.to_param => FactoryGirl.attributes_for(:user, first_name: 'Joost'),
                           user2.to_param => FactoryGirl.attributes_for(:user, email: 'Sofia'),
                           user3.to_param => FactoryGirl.attributes_for(:user)
                       }
      end

      it "does not change users attributes which are invalid" do
        user1.reload
        user2.reload
        user3.reload
        expect(user1.first_name).to eq('Joost')
        expect(user2.email).to eq('john.doe@mips.be')
        expect(user3.first_name).to eq('John')
      end

      it "re-renders the :edit_all method" do
        expect(response).to render_template :edit_all
      end
    end
  end
end
