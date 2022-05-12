module BxBlockComments
  class Comment < BxBlockComments::ApplicationRecord
    self.table_name = :comments

    belongs_to :account,
               class_name: 'AccountBlock::Account'

    belongs_to :post,
               class_name: 'BxBlockPosts::Post'

    has_many :likes,
              as: :likeable, class_name: 'BxBlockLike::Like', dependent: :destroy

    def self.policy_class
      ::BxBlockComments::CommentPolicy
    end
  end
end
