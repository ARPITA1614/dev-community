class MembersController < ApplicationController
    def show
        @user=User.find(params[:id])
        @connections = Connection.where("user_id = ? OR connected_user_id = ?", @user.id, @user.id).where(status: "accepted")
        @mutual_connections = current_user.mutually_connected_ids(@user)
    end

    def edit_description
       respond_to do |format|
    format.turbo_stream
    format.html { head :ok }
  end
    # respond_to do |format|
    #   format.turbo_stream
    # #   format.html # optional: fallback to normal HTML template if needed
    # end
  end

    def update_description

      if current_user.update(user_about_params)
      render_turbo_stream(
        "replace",
        "member-description",
        "members/member_description",
        { user: current_user }
      )

      #  respond_to do |format|
      #    if current_user.update(about: params[:user][:about])
      #       format.turbo_stream { render turbo_stream: turbo_stream.replace("member-description", partial: "members/member_description", locals: { user: current_user })}
      #    end
      #    end
      # if current_user.update(about: params[:user][:about])
      #    render turbo_stream: turbo_stream.replace(
      #      "member-description",
      #       partial: "members/member_description",
      #        locals: { user: current_user }
      #    )
      end
    end

  def edit_personal_details
         respond_to do |format|
    format.turbo_stream
    format.html { head :ok }
  end
  end

  def update_personal_details
    #  if current_user.update(user_personal_info_params)
    #   render_turbo_stream(
    #     "replace",
    #     "member_personal_details",
    #     "members/member_personal_details",
    #     { user: current_user }
    #   )
    # if current_user.update(user_personal_info_params)
    #   render turbo_stream: turbo_stream.replace(
    #     "member_personal_details",
    #     partial: "members/member_personal_details",
    #     locals: { user: current_user }
    #   )
    # else
    #   render :edit_personal_details, status: :unprocessable_entity
    # end
    if current_user.update(user_personal_info_params)

    @user = current_user

    @connections = Connection
      .where("user_id = ? OR connected_user_id = ?", @user.id, @user.id)
      .where(status: "accepted")

    @mutual_connections =
      current_user.mutually_connected_ids(@user)

    render turbo_stream: turbo_stream.replace(
      "member_personal_details",
      partial: "members/member_personal_details",
      locals: { user: @user }
    )
  end
  end

  def connections
    @user = User.find(params[:id])
    # @connected_users = User.where(id: @user.connected_user_ids)
    total_users = if params[:mutual_connections].present?
                    User.where(id: current_user.mutually_connected_ids(@user))
                  else
                    User.where(id: @user.connected_user_ids)
                  end
    @connected_users = total_users.page(params[:page]).per(10)
    @total_connections = total_users.count
    # @requested_connections=Connection.includes(:requested).where(user_id: params[:id], status: "accepted")
    # @received_connections=Connection.includes(:requested).where(connected_user_id: params[:id], status: "accepted")
    # @total_connections = total_users.count
    # @total_connections =  @requested_connections.count + @received_connections.count
  end


       private

  def user_about_params
    params.permit(user: [ :about ]).require(:user)
  end

 def user_personal_info_params
  params.require(:user).permit(:first_name, :last_name, :date_of_birth, :username, :city, :state, :country, :pincode, :street_address, :profile_title, :about, :contact_number)
 end

end

#  10.times do |requester_id|
  # [201, 1000, 92, 100, 1].each do |receiver_id|
    # Connection.create(user_id: requester_id + 300, connected_user_id: receiver_id, status: "accepted")
  # end
# end
# this is run 10 times provided user id=> receiver of request and requesterid+300 means start wuth 0 to 9 => requested id => 300 to 309
# this query will create 50 connections=> 10 for its user id as 201, 1000,...