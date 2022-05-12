FactoryBot.define do
  factory :comment, :class => 'BxBlockComments::Comment' do
    comment { "Test Comment" }
    account
    post
  end
end
