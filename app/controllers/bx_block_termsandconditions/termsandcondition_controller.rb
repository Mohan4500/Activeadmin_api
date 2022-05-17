class BxBlockTermsandconditions::TermsandconditionController < ApiController
def index
    @termsandconditions = Termsandcondition.all
     render json: @termsandconditions.to_json
  end
   def show
    @termsandconditions = Termsandcondition.find(params[:description])
    render json: @termsandconditions.to_json(:include => { :only => [:description] }})
  end
end
end
