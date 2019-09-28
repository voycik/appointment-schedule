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

  describe 'GET #show' do
    context 'Signed in physioterapist' do
      before :each do
        sign_in physio
        get :show, params: { id: appointment.id }
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
        get :show, params: { id: appointment.id }
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

      it 'renders the :new view from patient_card' do
        get :new, params: { patient_card_id: patient_card.id }
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
        it 'creates new appointment' do
          expect do
            post :create, params: { appointment: {
              user_id: physio.id,
              patient_card_id: patient_card.id,
              start_time: Time.now + 48.hours,
              end_time: Time.now + 49.hours
            } }
          end .to change { Appointment.count }.by(1)
        end

        it 'redirects to the new appointment' do
          post :create, params: { appointment: {
            user_id: physio.id,
            patient_card_id: patient_card.id,
            start_time: Time.now + 48.hours,
            end_time: Time.now + 49.hours
          } }
          expect(response).to redirect_to appointments_path
        end
      end
      context 'with invalid attributes' do
        it 'not create new appointment' do
          expect do
            post :create, params: { appointment: {
              user_id: nil,
              patient_card_id: nil,
              start_time: nil,
              end_time: nil
            } }
          end .to_not change { Appointment.count }
        end

        it 're-renders the new method' do
          post :create, params: { appointment: {
            user_id: nil,
            patient_card_id: nil,
            start_time: nil,
            end_time: nil
          } }
          expect(response).to render_template :new
        end
      end
    end
  end
end
