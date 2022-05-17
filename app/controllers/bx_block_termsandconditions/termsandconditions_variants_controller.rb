class BxBlockTermsandconditions::TermsandconditionsVariantsController < ApiController
def create
      variant = TermsandconditionsVariant.new(variants_params)
      save_result = variant.save

      if save_result
        render json: TermsandconditionsVariantSerializer.new(
          variant, serialization_options
        ).serializable_hash,
               status: :created
      else
        render json: ErrorSerializer.new(variant).serializable_hash,
               status: :unprocessable_entity
      end
    end

    def index
      serializer = TermsandconditionsVariantSerializer.new(
        TermsandconditionsVariant.all, serialization_options
      )

      render json: serializer, status: :ok
    end

    def variants_params
      params.permit(:termsandconditions_id, :termsandconditions_variant_color_id,
                    :termsandconditions_variant_size_id)
    end

    def serialization_options
      { params: { host: request.protocol + request.host_with_port } }
    end
  end
end
