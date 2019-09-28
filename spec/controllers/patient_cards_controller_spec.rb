# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PatientCardsController, type: :controller do
  it 'has a valid factory' do
    expect(FactoryBot.create(:appointment)).to be_valid
  end

  let!(:physio) { FactoryBot.create(:physio) }
  let!(:patient_card) { FactoryBot.create(:patient_card) }
  let(:appointment) { FactoryBot.create(:appointment) }

  subject { patient_card }
  describe 'GET #index' do
    context 'Signed in physioterapist' do
      before :each do
        sign_in physio
        get :index
      end

      it 'renders the :index view' do
        expect(response).to render_template(:index)
      end

      it 'populates an array of patient cards' do
        expect(assigns(:patients)).to eq([patient_card])
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

  describe 'GET #show' do
    context 'Signed in physioterapist' do
      before :each do
        sign_in physio
        get :show, params: { id: patient_card.id }
      end
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the :show view' do
        expect(response).to render_template(:show)
      end
    end
    context 'Non-signed in physioterapist' do
      before do
        get :show, params: { id: patient_card.id }
      end

      it 'redirects to sign in view' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #new' do
    context 'Signed in physioterapist' do
      before :each do
        sign_in physio
        get :new
      end
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the :new view' do
        expect(response).to render_template(:new)
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

  describe 'POST #create' do
    context 'Signed in physioterapist' do
      before :each do
        sign_in physio
      end
      context 'with valid attributes' do
        it 'creates new patient card' do
          expect do
            post :create, params: { patient_card: {
              first_name: 'Jan',
              last_name: 'Nowak',
              date_of_birth: Time.now - 48.years,
              phone_number: 123_123_123,
              comments: 'Lorem ipsum'
            } }
          end .to change { PatientCard.count }.by(1)
        end

        it 'redirects to the new patient card' do
          post :create, params: { patient_card: {
            first_name: 'Jan',
            last_name: 'Nowak',
            date_of_birth: Time.now - 48.years,
            phone_number: 123_123_123,
            comments: 'Lorem ipsum'
          } }
          expect(response).to redirect_to patient_cards_path
        end
      end
      context 'with invalid attributes' do
        it 'not create new patient card' do
          expect do
            post :create, params: { patient_card: {
              first_name: nil,
              last_name: nil,
              date_of_birth: nil,
              phone_number: 'invalid number',
              comments: 'nil'
            } }
          end .to_not change { PatientCard.count }
        end

        it 're-renders the new method' do
          post :create, params: { patient_card: {
            first_name: nil,
            last_name: nil,
            date_of_birth: nil,
            phone_number: 'invalid number',
            comments: 'nil'
          } }
          expect(response).to render_template :new
        end
      end
    end
    context 'Non-signed in physioterapist' do
      it 'not create new patient card' do
        expect do
          post :create, params: { patient_card: {
            first_name: nil,
            last_name: nil,
            date_of_birth: nil,
            phone_number: 'invalid number',
            comments: 'nil'
          } }
        end .to_not change { PatientCard.count }
      end

      it 'redirects to sign in view' do
        post :create, params: { patient_card: {
          first_name: nil,
          last_name: nil,
          date_of_birth: nil,
          phone_number: 'invalid number',
          comments: 'nil'
        } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
