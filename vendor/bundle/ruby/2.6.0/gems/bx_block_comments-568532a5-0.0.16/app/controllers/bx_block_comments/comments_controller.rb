module BxBlockComments
  class CommentsController < ApplicationController
    before_action :current_user
    before_action :validate_params, only: [:create, :update]
    before_action :post_exist, only: [:create, :update]
    before_action :load_comment, only: [:like, :dislike, :show]

    def index
      authorize BxBlockComments::Comment
      comments = Comment.where('account_id = ?', current_user.id)
      if params[:query].present?
        comments = comments.where('comment LIKE :search', search: "%#{params[:query]}%")
      end
      if comments.present?
        render json: CommentSerializer.new(
          comments,
          meta: {
            message: 'List of comments created by user.'
          }
        ).serializable_hash, status: :ok
      else
        render json: {
          errors: [
            { message: 'No comments.' },
          ]
        }, status: :ok
      end
    end

    def search
      @comments = Comment.where('comment ILIKE :search', search: "%#{search_params[:query]}%")

      render json: CommentSerializer.new(
        @comments, meta: {success: true, message: "Comment details."}
      ).serializable_hash, status: :ok
    end

    def show
      if @comment.present?
        authorize @comment
        render json: CommentSerializer.new(
          @comment,
          meta: { success: true, message: 'Comment details.' }
        ).serializable_hash, status: :ok
      else
        render json: {errors: [
          { success: false, message: 'Comment does not exist.' },
        ]}, status: :ok
      end
    end

    def create
      comment_params = jsonapi_deserialize(params)
      @comment = Comment.new(comment_params)

      authorize @comment

      @comment.account_id = current_user.id
      if @comment.save
        render json: CommentSerializer.new(
          @comment,
          meta: {
            message: "Comment created."
          }
        ).serializable_hash, status: :created
      else
        render json: { errors: format_activerecord_errors(@comment.errors) },
               status: :unprocessable_entity
      end
    end

    def update
      @comment = Comment.find_by(id: params[:id], account_id: current_user.id)

      return render json: {
        errors: [
          { message: 'Comment does not exist.' },
        ]
      }, status: :unprocessable_entity if !@comment.present?

      authorize @comment

      comment_params = jsonapi_deserialize(params)
      if @comment.update(comment: comment_params['comment'])
        render json: CommentSerializer.new(
          @comment, meta: {
            message: 'Comment updated.'
        }
        ).serializable_hash, status: :ok
      else
        render json: { errors: format_activerecord_errors(@comment.errors) },
               status: :unprocessable_entity
      end
    end

    def destroy
      @comment = Comment.find_by(id: params[:id], account_id: current_user.id)

      return render json: {
        errors: [
          { message: 'Comment does not exist.' },
        ]
      }, status: :unprocessable_entity if !@comment.present?

      authorize @comment

      if @comment.destroy
        render json: { message: 'Comment deleted.' }, status: :ok
      else
        render json: { errors: format_activerecord_errors(@comment.errors) },
               status: :unprocessable_entity
      end
    end

    def like
      like = @comment.likes.build(like_by_id: current_user.id)
      if like.save
        render json: CommentSerializer.new(@comment, {params: {current_user: current_user}}).serializable_hash,
                status: :ok
      else
        render json: { errors: format_activerecord_errors(like.errors) },
                status: :unprocessable_entity
      end
    end

    def dislike
      like = @comment.likes.find_by(like_by_id: current_user.id)
      if like.present?
        like.destroy
        render json: CommentSerializer.new(@comment, {params: {current_user: current_user}}).serializable_hash,
                status: :ok
      else
        render json: { errors: 'Record not found' },
               status: :not_found
      end
    end

    private

    def validate_params
      if params[:data].blank? || params[:data][:attributes].blank? ||
         params[:data][:attributes][:post_id].blank? || params[:data][:attributes][:comment].blank?
        return render json: {
          errors: [
            { message: 'Parameter missing.' },
          ]
        }, status: :unprocessable_entity
      end
    end

    def post_exist
      begin
        @post = BxBlockPosts::Post.find(params[:data][:attributes][:post_id])
      rescue ActiveRecord::RecordNotFound => e
        return render json: {
          errors: [
            { message: 'Post does not exist.' },
          ]
        }, status: :unprocessable_entity
      end
    end

    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end

    def search_params
      params.permit(:query)
    end

    def load_comment
      @comment = Comment.find_by(id: params[:id])
      if @comment.nil?
        render json: { message: 'Does not exist' },
               status: :not_found
      end
    end
  end
end
