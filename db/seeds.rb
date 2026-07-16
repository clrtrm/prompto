# frozen_string_literal: true

admin_user = User.find_or_create_by!(username: 'admin') do |user|
  user.display_name = 'Prompto Staff'
  user.email = 'admin@prompto.dev'
  user.password = 'changeme123!'
  user.role = :admin
end

# Create multiple users

users = 5.times.map do |n|
  User.find_or_create_by!(username: "user#{n}") do |user|
    user.display_name = "Test User #{n}"
    user.email = "user#{n}@prompto.dev"
    user.password = 'changeme123!'
    user.role = :member
  end
end

# Create multiple prompts

prompts =
  ["What's a new skill you're learning right now?",
   'If you could learn one secret from anyone, who would it be and what would it pertain to?',
   'Is there anything you think the next generation will do better than your generation?',
   "What's a common piece of advice you disagree with, and why?",
   "What's your earliest memory?"]

prompts.each { |p| Prompt.find_or_create_by!(body: p) }

# Create a prompt of the day

picnic_prompt = Prompt.find_or_create_by!(
  body: 'What is the greatest picnic food?'
)

todays_prompt = DailyPrompt.find_or_create_by!(
  date: Date.current
) do |dp|
  dp.prompt = picnic_prompt
end

# Create replies for the prompt of the day, from two different users

Reply.find_or_create_by!(
  daily_prompt: todays_prompt,
  user: admin_user
) do |reply|
  reply.body = 'A really good potato salad with MUSTARD'
end

Reply.find_or_create_by!(
  daily_prompt: todays_prompt,
  user: users.first
) do |reply|
  reply.body = 'Watermelon but people eat it so fast lol'
end
