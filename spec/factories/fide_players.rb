FactoryBot.define do
  factory :fide_player do
    association           :icu_player
    sequence(:id, 100000) { |i| i }
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    fed                   { "IRL" }
    gender                { "M" }
    born                  { nil }
    title                 { nil }
    rating                { nil }
  end
  factory :fide_player_with_icu_id, class: FidePlayer do
    sequence(:id, 100000) { |i| i }
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    fed                   { "IRL" }
    gender                { "M" }
    born                  { nil }
    title                 { nil }
    rating                { nil }
    icu_id                { nil }
  end
end
