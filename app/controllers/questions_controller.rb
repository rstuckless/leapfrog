require "pry"
class QuestionsController < ApplicationController
  def search
    @q = params[:q]
    skill = Skill.find_by_name(@q)
    if skill.nil?
      render "expertises/no_viable_experts"
    else
      @expertises = Expertise.where(skill_id: skill["id"])
      render "expertises/viable_experts"
    end
  end
end
