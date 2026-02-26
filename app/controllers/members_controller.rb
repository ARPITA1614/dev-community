class MembersController < ApplicationController
    def show
        @user=User.find(params[:id])
    end

    def edit_description
       @user=User.find(params[:id])
        respond_to do |format|
    format.turbo_stream
    format.html
  end
    end
end