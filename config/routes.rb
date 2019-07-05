# frozen_string_literal: true

Rails.application.routes.draw do
  get 'appointments/index'
  get 'appointments/show'
  get 'appointments/new'
  get 'appointments/create'
  get 'appointments/edit'
  get 'appointments/update'
  get 'appointments/destroy'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
