require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'PATCH #update_all users' do
    describe "valid attributes" do
      let (:user1) { FactoryGirl.create(:user) }
      let (:user2) { FactoryGirl.create(:user, first_name: 'Lara') }
      let (:user3) { FactoryGirl.create(:user) }
      before(:each) do
        # patch :update_all, user: FactoryGirl.attributes_for(:user)
        put :update_all, :user => {
                           user1.to_param => FactoryGirl.attributes_for(:user, first_name: 'Joost'),
                           user2.to_param => FactoryGirl.attributes_for(:user, first_name: 'Sofia'),
                           user3.to_param => FactoryGirl.attributes_for(:user)
                       }
      end

      it "changes the user's attributes if they were updated" do
        user1.reload
        user2.reload
        user3.reload
        expect(user1.first_name).to eq('Joost')
        expect(user2.first_name).to eq('Sofia')
        expect(user3.first_name).to eq('John')
      end

      # it "redirects to the updated referral of the patient" do
      #   expect(response).to redirect_to(patient_referral_path(assigns(:patient), assigns(:referral)))
      # end
    end

    # describe "invalid attributes" do
    #   before(:each) do
    #     patch :update_all, blood_bag_id: @blood_bag_attribute.bbat_BloodBag,
    #           id: @blood_bag_attribute, blood_bag_attribute: FactoryGirl.attributes_for(:blood_bag_attribute)
    #   end

      # it "does not change @referral's person attributes" do
      #   expect(assigns[:referral]).to eq @referral
      # end
      #
      # it "re-renders the :edit method" do
      #   expect(response).to render_template :edit
      # end
  #   end
  end
end
