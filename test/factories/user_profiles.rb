FactoryBot.define do
  factory :user_profile do
    bio { "MyString" }
    avatar { "MyString" }
    username { "MyString" }
    name { "MyString" }
    website { "MyString" }
    background_color { "MyString" }
    foreground_color { "MyString" }
    location { "MyString" }
    user { nil }
  end
end
