# frozen_string_literal: true

User.find_or_create_by!(username: 'admin') do |user|
  user.display_name = 'Prompto Staff'
  user.email = 'admin@prompto.dev'
  user.password = 'changeme123!'
  user.role = :admin
end

5.times do |n|
  User.find_or_create_by!(username: "user#{n}") do |user|
    user.display_name = "Test User #{n}"
    user.email = "user#{n}@prompto.dev"
    user.password = 'changeme123!'
    user.role = :member
  end
end

prompts =
  ["What's a new skill you're learning right now?",
   'If you could learn one secret from anyone, who would it be and what would it pertain to?',
   'Is there anything you think the next generation will do better than your generation?',
   "What's a common piece of advice you disagree with, and why?",
   "What's your earliest memory?"]

prompts.each { |p| Prompt.find_or_create_by!(body: p) }
