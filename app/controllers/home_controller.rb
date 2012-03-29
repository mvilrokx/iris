class HomeController < ApplicationController
  respond_to :json, :html

  def index
  end

  def process_speech
    puts params[:utterance]
    respond_with(["Server received: #{params[:utterance]}"])
  end

end
