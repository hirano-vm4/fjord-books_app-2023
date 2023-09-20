# frozen_string_literal: true

module ApplicationHelper
  # localeに応じて複数形の表記を変える
  # - 日本語の場合 => 本
  # - 英語の場合 => books
  def i18n_pluralize(word)
    I18n.locale == :ja ? word : word.pluralize
  end

  # localeに応じてエラー件数の表記を変える
  # - 日本語の場合 => 3件のエラー
  # - 英語の場合 => 3 errors
  def i18n_error_count(count)
    I18n.locale == :ja ? "#{count}件の#{t('views.common.error')}" : pluralize(count, t('views.common.error'))
  end

  def format_content(content)
    safe_join(content.split("\n"), tag.br)
  end

  def create_sanitize_links(content)
    uris = URI.extract(content, %w[http https])
    modified_text = Marshal.load(Marshal.dump(content))
    uris.each { |uri| modified_text = modified_text.sub(uri, "<a href=\"#{uri}\">#{uri}</a>") }
    sanitize(modified_text, tags: %w[a], attributes: %w[href])
  end
end
