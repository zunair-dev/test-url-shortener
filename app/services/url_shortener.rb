class UrlShortener
  BASE62_CHARS = [ *"0".."9", *"a".."z", *"A".."Z" ].freeze

  def self.generate_short_url
    digest = Digest::SHA256.hexdigest(Time.now.to_f.to_s).to_i(16)
    base62_encode(digest)[0...8]
  end

  private

  def self.base62_encode(number)
    return BASE62_CHARS[0] if number.zero?

    result = ""
    base = BASE62_CHARS.size

    while number.positive?
      result.prepend(BASE62_CHARS[number % base])
      number /= base
    end

    result.rjust(8, BASE62_CHARS[0])
  end
end
