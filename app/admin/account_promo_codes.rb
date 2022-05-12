ActiveAdmin.register BxBlockPromoCodes::AccountPromoCode, as: 'Account Promo Codes' do
  permit_params :promo_code_id, :account_id, :redeem_count

  form do |f|
    f.inputs do
      f.input :promo_code
      f.input :account
      f.input :redeem_count
    end
    f.actions
  end
end
