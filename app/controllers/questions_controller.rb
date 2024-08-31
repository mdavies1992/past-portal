class QuestionsController < ApplicationController
  def index
    @questions = current_user.questions
    @question = Question.new # for form
  end

  def create
    @questions = current_user.questions # needed in case of validation error
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:questions, partial: "questions/question",
          locals: { question: @question })
        end
        format.html { redirect_to questions_path }
      end
    else
       render :index
    end
  end

    private

    def question_params
      params.require(:question).permit(:user_question)
    end

    def purge
      @questions = current_user.questions
      if @questions.destroy_all.any?
        redirect_to questions_path, notice: "All questions were successfully deleted."
      else
        redirect_to questions_path, alert: "Failed to delete questions."
      end
    end
end
