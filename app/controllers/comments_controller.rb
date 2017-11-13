class CommentsController < ApplicationController

  before_action :set_photo


  def index
    @comment = Comment.all
  end

  def show
    @comment.user = current_user
    @comment.created_at = time_ago_in_words(Time.now, include_seconds: true)
  end

  def edit

  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @photos, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  def create
    @comment = @photo.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to root_path
    # respond_to do |format|
    #   if @comment.save
    #     format.html { redirect_to root_path, notice: 'comment was successfully created.' }
    #     format.json { render :show, status: :created, location: @comment }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @comment.errors, status: :unprocessable_entity }
    #   end
  end


    def destroy
      @comment = @photo.comments.find(params[:id])
      @comment.destroy
      redirect_to root_path
    end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_photo
    @photo = Photo.find(params[:photo_id])

  end
end
