# frozen_string_literal: true

FactoryBot.define do
  factory :campaign do
    name { 'MyString' }

    trait :with_images do
      transient do
        images_count { 5 }
      end

      after(:create) do |campaign, _evaluator|
        campaign.source_images.attach(io: Rails.root.join('spec/fixtures/image.jpg').open,
                                      filename: 'image.jpg',
                                      content_type: 'image/jpg')
      end
    end
  end
end
