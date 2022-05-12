module BxBlockComments
  class CommentSerializer < BuilderBase::BaseSerializer
    include FastJsonapi::ObjectSerializer
    attributes *[
        :id,
        :account_id,
        :post_id,
        :comment,
        :created_at,
        :updated_at,
        :post,
        :account
    ]

    attribute :liked do |object, params|
      object.likes.where(like_by_id: params[:current_user].id).present? if params[:current_user].present?
    end
  end
end
