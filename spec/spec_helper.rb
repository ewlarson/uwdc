RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end

# AfricaFocus - Hyena Wrestler with Muzzled Hyena
def get_africa_focus_mets
  @get  = Nokogiri::XML.parse("../fixtures/africa_focus_mets.xml")
  @id   = 'ECJ6ZXEYWUE7B8W'
end

# Artists' Books - A broth for two parents
def get_artists_books_mets
  @get  = Nokogiri::XML.parse("../fixtures/artists_books_mets.xml")
  @id   = 'CXEB4DPJEOYTM8C'
end

# Publishers' Bindings - A life idyl
def get_publishers_bindings_mets
  @get  = Nokogiri::XML.parse("../fixtures/publishers_bindings_mets.xml")
  @id   = '33QOBSVPJLWEM8S'
end