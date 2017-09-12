require "pry"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Todo.create!(title: 'grocery shopping', notes: 'pickles, eggs, red onion')
# Todo.create!(title: 'wash the car')
# Todo.create!(title: 'register kids for school', notes: 'Register Kira for Ruby Junior High and Caleb for Rails High School')
# Todo.create!(title: 'check engine light', notes: 'The check engine light is on in the Tacoma')
# Todo.create!(title: 'dog groomers', notes: 'Take Pinky and Redford to the groomers on Wednesday the 23rd')
user_data_raw = File.read("./user_data.json")
user_data_parsed = JSON.parse(user_data_raw)
expertise_levels = ["Initiate", "Padawan", "Master"]
user_data_parsed["users"].each do |user|
  if user["skills"].length > 0
    expert = Expert.create!(email: user["email"], name: user["first_name"] + " " + user["last_name"], picture_url: user["avatar_urls"]["icon"])
    user["skills"].each do |skill|
      skill = Skill.find_or_create_by!(name: skill)
      expertise = Expertise.create!(expert_id: expert["id"], skill_id: skill["id"], level: expertise_levels.sample)
    end
  end
end
