class BxBlockTermsandconditions::TagsController < ApiController

    def create
      tag = Tag.new(description: params[:description])
      save_result = tag.save

      if save_result
        render json: TagSerializer.new(tag).serializable_hash,
               status: :ok
      else
        render json: ErrorSerializer.new(tag).serializable_hash,
               status: :unprocessable_entity
      end
    end

    def index
      serializer = TagSerializer.new(Tag.all)

      render json: serializer, status: :ok
    end
  end
end


