# frozen_string_literal: true

FactoryBot.define do
  factory :physio do
    email { Faker::Internet.email }
    password  { '123qwe' }
  end
end
