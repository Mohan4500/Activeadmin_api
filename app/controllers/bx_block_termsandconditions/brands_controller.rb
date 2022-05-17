class BxBlockTermsandconditions::BrandsController < ApiController
 def create
      brand = Brand.new(description: params[:description])
      save_result = brand.save

      if save_result
        render json: BrandSerializer.new(brand).serializable_hash,
               status: :created
      else
        render json: ErrorSerializer.new(brand).serializable_hash,
               status: :unprocessable_entity
      end
    end

    def index
      serializer = BrandSerializer.new(Brand.all)

      render json: serializer, status: :ok
    end
  end
end
