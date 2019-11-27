class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  # create hash such that {0: '0', 1: '1'.. 61: 'Z'} for ID conversion
  CHARS_HASH = CHARACTERS.each_with_index.inject({}) { |hash, value| hash.merge(value[1] => value[0]) }

  validates :full_url, presence: true
  validate :validate_full_url

  def short_code
    # new id of instance is either (last entry's id + 1) or 1 if there are no entries so far
    new_id = ShortUrl.last ? ShortUrl.last.id + 1 : 1
    self.short_code = create_short_code(new_id - 1)
  end

  def update_title!
  end

  private

  def validate_full_url
  end

  def create_short_code(id_num)
    short_code = ''
    count = id_num

    while ((count) >= 62)
      # minus 1 to account for hash starting at 0
      num = ((count / 62) - 1) % 62
      short_code = CHARS_HASH[num].to_s + short_code
      count = (count/62) - 1
    end
    short_code + CHARS_HASH[id_num % 62].to_s
  end

end
