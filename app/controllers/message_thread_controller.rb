class MessageThreadController < ApplicationController
  before_filter :authenticate_user
  before_action :message, only: [:show, :update]
  before_action :conversation, only: [:reply, :conversation]

  def index
    @conversations = @current_user.conversations
    respond_to do |format|
      format.html
      format.json {
        render json: {
          id: @conversations.map {|x| x.id},
          unread_messages: @conversations.each {|x| x.messages.select {|z| z.read == false}}.count
        }.to_json
      }
    end
  end

  def new
  end

  def create
    @conversation = Conversation.new(sender_id: @current_user.id, subject: params[:subject])

    if !params[:recipients].nil?
      @conversation.users << @current_user
      @conversation.users << User.find(params[:recipients])
    end

    if @conversation.save
      @message = @conversation.messages.new(sender_id: @current_user.id, message_text: params[:message_text])
      if @message.save
        redirect_to action: "show", id: @message.id
      else
        flash[:error] = @message.errors.full_messages.to_sentence
        redirect_to new_message_thread_path
      end
    else
      flash[:error] = @conversation.errors.full_messages.to_sentence
      redirect_to new_message_thread_path
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json {
        render json: {
          id: @message.id,
          message_text: @message.message_text,
          author: @message.email
        }.to_json
      }
    end
  end

  def reply
    @message = @conversation.messages.new(sender_id: @current_user.id, message_text: params[:message_text])

    if @message.save
      flash[:notice] = "New message recieved for conversation thread"
      redirect_to action: "conversation", id: @conversation.id
    else
      flash[:error] = @message.errors.full_messages.to_sentence
      redirect_to action: "show", id: @message.id
    end
  end

  def conversation
  end

  def update
    @message.read = true
    if @message.save!
      flash[:notice] = "Message ID #{@message.id} marked as read"
    else
      flash[:notice] = "Message ID #{@message.id} was not marked as read, error"
    end
    redirect_to action: "conversation", id: @message.conversation.id
  end

  private

  def message
    @message ||= Message.find(params[:id])
  end

  def conversation
    @conversation ||= Conversation.find(params[:id])
  end

end
