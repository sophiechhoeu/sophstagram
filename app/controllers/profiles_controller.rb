class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]


  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    if params[:id]
      @profile = Profile.find_by!(user: params[:id])
      @photos = @profile.user.photos

    else
      @photos = current_user.photos
      @profile = current_user.profile
    end

    # @profile = Profile.find(user_id: current_user.id)
  end


  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find_or_initialize_by(:user => current_user)
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update



    # we fetch that user
    # user = User.find(param)
    # user.followers << current_user


    # @profile.user.followers << current_user
    respond_to do |format|

      # debug later why user param is empty in performing_follow method
      if performing_follow?
         @profile.user.toggle_followed_by(current_user)
        #  format.html { redirect_to @profile.user }
        #  format.json { render :show, status: :ok, location: @profile }
      elsif @profile.update(profile_params)
          format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
          format.json { render :show, status: :ok, location: @profile }
      else
          format.html { render :edit }
          format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
      def set_profile
        if params[:id]
          #find a user by profile
          @profile = Profile.find_by(user_id: params[:id])
          # puts "33333333333333333333"
          # puts @profile
          # puts "33333333333333333333"


        else
          #the signed in user's profile
          @profile = Profile.find_by(:user => current_user.id)

          # puts "33333333333333333333"
          # puts @profile
          # puts "33333333333333333333"
        end

      end


      # Never trust parameters from the scary internet, only allow the white list through.
      def profile_params
        params.require(:profile).permit(:avatar, :name, :bio, :user_id)
      end

      def performing_follow?
          params.dig(:user, :toggle_follow).present?
      end

end
