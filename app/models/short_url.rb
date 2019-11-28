require 'open-uri'
# Full url is not a valid url

class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validates :full_url, presence: true
  validate :validate_full_url
  attr_reader :short_code

  def short_code
    return nil if !self.id?
    return @short_code if @short_code
    @short_code = create_short_code(self.id)
    self.update(short_code: @short_code)
    return @short_code
  end

  def update_title!
    title = open(self.full_url).read.scan(/<title>(.*?)<\/title>/)[0][0]
    self.update(title: title)
  end

  private

  def validate_full_url
    # if response from full_url is not 200-OK, then add to errors
    errors.add(:full_url, "is not a valid url") if open(self.full_url).status[0] != '200' 
  rescue 
    # add to errors if full_url cannot be connected with
    errors.add(:full_url, "is not a valid url")
  end

  def create_short_code(id)
    short_code = ''
    id_num = id

    while ((id_num) >= 62)
      # minus 1 to account for hash starting at 0
      num = ((id_num / 62) - 1) % 62
      short_code = CHARACTERS[num].to_s + short_code
      id_num = (id_num/62) - 1
    end
    short_code + CHARACTERS[id % 62].to_s
  end

end
