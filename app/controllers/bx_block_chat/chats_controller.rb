module BxBlockChat
  class ChatsController < ApplicationController
    before_action :find_chat, only: [:read_messages]

    def index
      chats = current_user.chats
      render json: ::BxBlockChat::ChatOnlySerializer.new(chats, serialization_options).serializable_hash, status: :ok
    end

    def show
      chat = BxBlockChat::Chat.where(id: params[:id]).includes('accounts')
      render json: ::BxBlockChat::ChatSerializer.new(chat, serialization_options).serializable_hash, status: :ok
    end

    def create
      chat = BxBlockChat::Chat.new(chat_params)
      chat.chat_type = 'multiple_user'
      if chat.save
        BxBlockChat::AccountsChatsBlock.create(account_id: current_user.id,
                                                  chat_id: chat.id,
                                                   status: :admin)
        render json: ::BxBlockChat::ChatSerializer.new(chat, serialization_options).serializable_hash, status: :created
      else
        render json: {errors: chat.errors}, status: :unprocessable_entity
      end
    end

    def history
      chat_ids = AccountBlock::Account.find(params[:receiver_id])&.chats&.pluck(:id)
      chat = current_user&.chats&.where(id: chat_ids)&.first
      if chat.present?
        chat_history = chat&.messages&.order('created_at ASC')
        render json: ChatMessageSerializer.new(chat_history, serialization_options).serializable_hash, status: :ok
      else
        render json: { message: "They don't have any chat history" }
      end
    end

    def read_messages
      begin
        @chat.messages&.all.update(is_mark_read: true )
        render json: { message: "Message read successfully" }
      rescue Exception=> e
        render json: { error: e }
      end
    end

    def update
      #TODO
    end

    def search
      @chats = current_user
                 .chats
                 .where('name ILIKE :search', search: "%#{search_params[:query]}%")
      render json: ChatSerializer.new(@chats, serialization_options).serializable_hash, status: :ok
    end

    def search_messages
      @messages = ChatMessage
                    .where(chat_id: current_user.chat_ids)
                    .where('message ILIKE :search', search: "%#{search_params[:query]}%")
      render json: ChatMessageSerializer.new(@messages, serialization_options).serializable_hash, status: :ok
    end

    private

    def chat_params
      params.require(:chat).permit(:name)
    end

    def search_params
      params.permit(:query)
    end

    def find_chat
      @chat = Chat.find_by_id(params[:chat_id])
      render json: {message: "Chat room is not valid or no longer exists" } unless @chat
    end
  end
end
