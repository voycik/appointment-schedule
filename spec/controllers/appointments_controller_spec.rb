require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do

  let!(:physio) { FactoryBot.create(:physio) }
  let!(:patient_card) { FactoryBot.create(:patient_card) }

  it 'has a valid factory' do
    expect(FactoryBot.create(:appointment)).to be_valid
  end

  let!(:physio) { FactoryBot.create(:physio) }
  let!(:patient_card) { FactoryBot.create(:patient_card) }
  let(:appointment) { FactoryBot.create(:appointment) }

  subject { appointment }
  describe "GET #index" do

    context 'Signed in physioterapist' do
      before :each do
        sign_in physio
        get :index
      end
      it 'renders the :index view' do
       expect(response).to render_template(:index)
     end
    end
  end
  #
  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #destroy" do
  #   it "returns http success" do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
