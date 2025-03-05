FactoryBot.define do
  factory :training_setup do
    campaign { nil }
    r { 1 }
    learning_rate { 1.5 }
    training_steps { 1 }
    base_model { "MyString" }
    sampler { "MyString" }
    scheduler { "MyString" }
    status { "MyString" }
    network_dropout { 1.5 }
  end
end
