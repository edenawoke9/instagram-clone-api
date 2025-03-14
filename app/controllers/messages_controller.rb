class MessagesController < ApplicationController
    def create
      # Find the sender and receiver by their user IDs
      sender = User.find(params[:sender_id])
      receiver = User.find(params[:receiver_id])
  
      # Create the message
      @message = Message.create(
        sender: sender,
        receiver: receiver,
        content: params[:content]
      )
  
    
      if @message.persisted?
        render json: @message, only: [:id, :sender_id, :receiver_id, :content, :created_at]
      else
        render json: { error: 'Message could not be sent' }, status: :unprocessable_entity
      end
    end
    class MessagesController < ApplicationController
        before_action :authenticate_user!  # Ensure current_user is available
      
        # Fetch all sent messages
        def sent_messages
          @sent_messages = current_user.sent_messages
      
          render json: @sent_messages, only: [:id, :sender_id, :receiver_id, :content, :created_at]
        end
      
        # Fetch all received messages
        def received_messages
          @received_messages = current_user.received_messages
      
          render json: @received_messages, only: [:id, :sender_id, :receiver_id, :content, :created_at]
        end
      end
      
  end
  