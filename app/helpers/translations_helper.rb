module TranslationsHelper
  def translation_keys(i18n_locale)
    I18n.backend.translations_store(i18n_locale)
  end

  def prefixed_translation_keys(locale, prefix)
    translation_keys(locale).select { |k| !k.nil? && k.starts_with?(prefix)  }
  end

  def price_category_translations(locale)
    prefixed_translation_keys(locale, 'price-categories')
      .select { |key| !key.nil? && !(key.ends_with?('.currency') || key.ends_with?('.special') || key.ends_with?('.items')) }
  end


  private

  # def en_keys
  # end

  # def de_keys
  #   [ "landing-page.edit.welcome_text", "site_description", "contact_name" ]
  # end

  # def default_keys
  #   [
  #     "landing-page.prices.headline",
  #     "price-categories.first-try.headline",
  #     "price-categories.first-try.sub-headline",
  #     "price-categories.first-try.offers.trial.headline",
  #     "price-categories.first-try.offers.trial.price",
  #     "price-categories.first-try.offers.new-customer-1.headline",
  #     "price-categories.first-try.offers.new-customer-1.price",
  #     "price-categories.first-try.offers.new-customer-1.info",
  #     "price-categories.first-try.offers.new-customer-2.headline",
  #     "price-categories.first-try.offers.new-customer-2.price",
  #     "price-categories.first-try.offers.new-customer-2.info",
  #   ]
  # end

  def translation_for_key(translations, key)
    hits = translations.to_a.select{ |t| t.key == key }
    hits.first
  end
end
