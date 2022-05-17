ActiveAdmin.register Termsandcondition do
 # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :description
  form do |f|
    f.inputs 'Terms and Conditions' do
      f.input :description, as: :quill_editor
    end
    f.actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
