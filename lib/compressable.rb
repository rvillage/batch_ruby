class Compressible
  class MisfortuneError < StandardError; end

  class << self
    def compress_number(original_text)
      god_knows!

      return original_text if original_text.blank?

      text = original_text.tr('０-９', '0-9')
      text.gsub!(/\D/, '')
      text
    end

    def god_knows!
      if (Time.new.usec % 1_000).zero? && rand(10).zero?
        raise MisfortuneError.new 'Bad luck, my friend.'
      end
    end
  end
end
