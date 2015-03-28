class SsidsController < ApplicationController
  def index
    @ssid = Ssid.new
    @list = Array.new
    regex = /(^!.+|^\S+\s+\d+\s+\d+\s+\S+\s+\S+\s+)/
    @wiproid = Wiproid.find(Checkout.where(userid: current_user.id).last.wiproid)
    @name = File.open("/home/rails/public/uploads/hex/#{@wiproid.wiproid}/ssid.txt").read
    @name.each_line do |line|
      @list = @list + line.tr(regex, "")
    end
  end
  def create
    @ssid = Ssid.new(ssid_params)
    if @ssid.save
      flash[:success] = "Wireless Network Saved!"
      redirect_to "/"
    else
      render "index"
    end
  end
  def refresh
    redirect_to "/ssids"
  end
private
  def ssid_params
    params.require(:ssid).permit(:wiproid, :ssid, :password)
  end
end
