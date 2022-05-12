Rails.application.reloader.to_prepare do
  AccountBlock::Account.include(
    BxBlockLinkShare::PatchAccountBlockAccount
  )
end
