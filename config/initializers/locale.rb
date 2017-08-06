require 'i18n/backend/active_record'

Translation  = I18n::Backend::ActiveRecord::Translation

def flat_hash(hash, f=nil, g={})
  return g.update({ f => hash }) unless hash.is_a? Hash
  hash.each { |k, r| flat_hash(r, [f,k].compact.join('.'), g) }
  g
end

class I18n::Backend::Simple
  def translations_store(locale)
    init_translations unless initialized?

    flat_hash(translations[locale]).keys
  end
end

class I18n::Backend::ActiveRecord
  def translations_store(locale)
    Translation.all.map { |t| t.key }
  end
end

class I18n::Backend::Chain
  def translations_store(locale)
    backends.map { |backend| backend.translations_store(locale) }.flatten.uniq
  end
end



if Translation.table_exists?
  I18n.backend = I18n::Backend::ActiveRecord.new

  I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Memoize)
  I18n::Backend::Simple.send(:include, I18n::Backend::Memoize)
  I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)
  # look online first, fall back to yml
  I18n.backend = I18n::Backend::Chain.new(I18n.backend, I18n::Backend::Simple.new)

  I18n::Backend::ActiveRecord.configure do |config|
    config.cleanup_with_destroy = true # defaults to false
  end
end
