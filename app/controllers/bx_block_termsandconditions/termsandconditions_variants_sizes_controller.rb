class BxBlockTermsandconditions::TermsandconditionsVariantsSizesController < ApiController
 def create
      sizes = TermsandconditionsVariantSize.new(description: params[:description])
      save_result = sizes.save

      if save_result
        render json: TermsandconditionsSizeSerializer.new(sizes)
                         .serializable_hash,
               status: :created
      else
        render json: ErrorSerializer.new(sizes).serializable_hash,
               status: :unprocessable_entity
      end
    end

    def index
      serializer = TermsandconditionsSizeSerializer.new(TermsandconditionsVariantSize.all)

      render json: serializer, status: :ok
    end
  end
end
end
