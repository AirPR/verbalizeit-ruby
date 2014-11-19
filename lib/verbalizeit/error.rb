module VerbalizeIt
  module Error
    class ClientError < StandardError; end
    class ServerError < StandardError; end
    class BadRequest < StandardError; end
    class Unauthorized < StandardError; end
    class NotFound < ClientError; end
    class Unavailable < StandardError; end
    class LanguageCodeNotValid < StandardError; end

    def handle_response(response) # :nodoc:
      case response.code
        when 400
          raise BadRequest.new response.inspect
        when 401
          raise Unauthorized.new
        when 404
          raise NotFound.new
        when 400...500
          raise ClientError.new response.inspect
        when 500...600
          raise ServerError.new response.inspect
        else
          response.parsed_response
      end
    end
  end
end