module VerbalizeIt
  module Text
    def basic_text(lang_code, text, postback_url, notes = nil)
      options = {
        text: text,
        language: lang_code,
        postback_url: postback_url
      }
      options[:notes] = notes unless notes.nil?
      post("/tasks/basic.json", options)
    end

    def status(id)
      get("/tasks/#{id}/status.json")
    end
  end
end
