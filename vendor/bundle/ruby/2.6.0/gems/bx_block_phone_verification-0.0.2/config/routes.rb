BxBlockPhoneVerification::Engine.routes.draw do
  post 'send_sms_otp', to: 'phone_verifications#send_sms_otp'
  post 'verify_sms_otp', to: 'phone_verifications#verify_sms_otp'
end
