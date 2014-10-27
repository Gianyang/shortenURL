class Url < ActiveRecord::Base
  before_create :shorten_url
  validate :url_valid?

  def add_count
    self.click_count += 1
    save
  end

  private

  def shorten_url
    p "----------->"
    begin
    short_url = "http://localhost:9393/" + [*'0'..'9', *'a'..'z', *'A'..'Z'].shuffle.first(7).join
    end until url_unique(short_url)
    p "#{short_url}------------------------>"
    self.shorten_link = short_url
  end

  def url_unique(url)
    Url.where(shorten_link: url).count == 0
  end

  def url_valid?
    uri = URI.parse(self.full_link)
    errors.add(:full_link, "Not valid url") unless uri.kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
      false
      errors.add(:full_link, "Not valid url")
  end



end
