ActiveAdmin.register BxBlockPromoCodes::RestaurantPromoCode, as: 'Restaurant Promo Codes' do
  permit_params :promo_code_id, :restaurant_id

  form do |f|
    f.inputs do
      f.input :promo_code
      f.input :restaurant_id
    end
    f.actions
  end
end
