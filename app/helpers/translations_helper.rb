module TranslationsHelper
  def translation_keys(i18n_locale)
    # case i18n_locale
    # when "en"
    #   en_keys
    # when "jp"
    #   jp_keys
    # else
      default_keys
    # end
  end

  private

  # def en_keys
  # end

  # def de_keys
  #   [ "landing-page.edit.welcome_text", "site_description", "contact_name" ]
  # end

  def default_keys
    [
      "landing-page.prices.headline",
      "price-categories.first-try.headline",
      "price-categories.first-try.sub-headline",
      "price-categories.first-try.offers.trial.headline",
      "price-categories.first-try.offers.trial.price",
      "price-categories.first-try.offers.new-customer-1.headline",
      "price-categories.first-try.offers.new-customer-1.price",
      "price-categories.first-try.offers.new-customer-1.info",
      "price-categories.first-try.offers.new-customer-2.headline",
      "price-categories.first-try.offers.new-customer-2.price",
      "price-categories.first-try.offers.new-customer-2.info",
    ]
  end

  def translation_for_key(translations, key)
    hits = translations.to_a.select{ |t| t.key == key }
    hits.first
  end
end
