require "pry"
class QuestionsController < ApplicationController
  def search
    @q = params[:q]
    skill = Skill.find_by_name(@q)
    @expertises = Expertise.where(skill_id: skill["id"])
    render "expertises/viable_experts"
  end
end
