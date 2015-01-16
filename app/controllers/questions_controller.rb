class QuestionsController < ApplicationController

  before_action :find_question, only: [:show, :edit, :update, :destroy]
  

  def index
    @questions = Question.all
  end

  def edit
    @question = Question.find params[:id]
  end

  def new 
    @question = Question.new
  end

  def update  
    if @question.update question_params
    render text: params, notice: "Updated Successfully"
    else
    render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: "Deleted Succesfully"
  end

  def create 
    @question = Question.new question_params
    if @question.save 
       #redirect_to question_path(@question.id)
      redirect_to @question, notice: "Created Successfully!"
     else
      render :new
    end
  end

  def show  
    @question.increment!(:view_count)
    #@question.view_count +=1
    #@question.save
    #render text: params
  end

  def find_question
    @question = Question.find params[:id]
  end

  def question_params
  params.require(:question).permit(:title, :body)
  end 

end
