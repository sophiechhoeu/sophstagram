class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
    @profile = Profile.all
    @comment = Comment.new
    if params[:search]
     @photos = Photo.search(params[:search]).order("created_at DESC") #created_at: :desc
   else
     @photos = Photo.all.order("created_at DESC")
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo.user = current_user
    redirect_to root_path
  end

  # GET /photos/new
  def new
    # @photo = Photo.new
    @photo = current_user.photos.build
  end

  # GET /photos/1/edit
  def edit
    @photo.user = current_user
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = current_user.photos.build(photo_params)
    @photo.user = current_user


    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end

  end

  def upvote
    @photo = Photo.find(params[:id])
    @photo.upvote_by current_user
    redirect_to root_path
  end

  def downvote
    @photo = Photo.find(params[:id])
    @photo.downvote_by current_user
    redirect_to root_path
  end



  # def comment
  #     @photo = Photo.find(params[:id])
  #     @photo.comments << Photo.new(params[:comment])
  #     redirect_to root_path
  # end


  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
     @photo.destroy
     respond_to do |format|
       format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
       format.json { head :no_content }
     end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image, :user_id, :caption)
    end

end
