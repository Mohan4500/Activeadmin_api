Rails.application.reloader.to_prepare do
  BxBlockCatalogue::Catalogue.include(
    BxBlockLinkShare::PatchCatalogueBlockCatalogue
  )
end
