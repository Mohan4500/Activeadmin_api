class BxBlockTermsandconditions::TermsandconditionsVariantsColorsController < ApiController
 def create
      colors = TermsandconditionsVariantColor.new(description: params[:description])
      save_result = colors.save

      if save_result
        render json: TermsandconditionsVariantColorSerializer.new(colors)
                         .serializable_hash,
               status: :created
      else
        render json: ErrorSerializer.new(colors).serializable_hash,
               status: :unprocessable_entity
      end
    end

    def index
      serializer = TermsandconditionsVariantColorSerializer.new(
        TermsandconditionsVariantColor.all
      )

      render json: serializer, status: :ok
    end
  end
end
