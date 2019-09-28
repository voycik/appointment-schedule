# frozen_string_literal: true

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
  describe 'GET #index' do
    context 'Signed in physioterapist' do
      before :each do
        sign_in physio
        get :index
      end

      it 'renders the :index view' do
        expect(response).to render_template(:index)
      end

      it 'populates an array of appointments' do
        expect(assigns(:appointments)).to eq([appointment])
      end
    end

    context 'Non-signed in physioterapist' do
      before do
        get :index
      end

      it 'redirects to sign in view' do
        expect(response).to redirect_to(new_user_session_path)
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

  describe "GET #new" do
    context 'Signed in physioterapist' do
      before :each do
        sign_in physio
        get :new
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it 'renders the :new view' do
        expect(response).to render_template(:new)
      end

      it 'renders the :new view from patient_card' do
        get :new, params: {patient_card_id: patient_card.id}
      end
    end

    context 'Non-signed in physioterapist' do
      before do
        get :new
      end

      it 'redirects to sign in view' do
        expect(response).to redirect_to(new_user_session_path)
      end

    end
  end
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
