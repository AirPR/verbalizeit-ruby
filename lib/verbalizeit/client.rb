module VerbalizeIt
  class Client
    include HTTMultiParty
    include Language
    include Error

    attr_accessor *Configuration::VALID_OPTIONS

    def initialize(options={})
      merged_options = VerbalizeIt.options.merge(options)

      Configuration::VALID_OPTIONS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end

    ##
    # List available languages for translation. Each language consists of a name and a language/region code.
    # The language/region code is used to set the source and target language when posting a new task.
    #
    # @param  None
    # @return [Array] Status: 200 OK
    #  [
    #    {
    #        "name":"English",
    #        "language_region_code":"eng-US"
    #     },
    #    {
    #        "name":"Arabic",
    #        "language_region_code":"ara-AE"
    #     },
    #    {
    #        "name":"Bosnian",
    #        "language_region_code":"tur-TR"
    #     },
    #    {
    #        "name":"French",
    #        "language_region_code":"fra-Fr"
    #     }
    #  ]
    def languages
      get("/#{api_version}/languages.json")
    end

    ##
    # Lists all submitted tasks, sorted by creation date.
    #
    # @param  [Integer]   start   (optional)  Index of starting task
    # @param  [Integer]   limit   (optional)  Maximum number of tasks to return
    # @param  [String]    status  (optional)  Status Type:
    #                                           "complete" - finished and ready to download
    #                                           "working" - currently being translated
    #                                           "confirmed" - working or complete
    #                                           "preview" - not yet started
    # @return [Hash]  Status: 200 OK
    #  {
    #    "total" : 100,
    #    "start" : 0,
    #    "limit" : 10,
    #    "tasks" : [
    #      {
    #        id: "TX1234",
    #        url: "http://localhost.verbalizeit.com:3000/v2/tasks/TCAAA"
    #        status: "complete",
    #        rush_order: false,
    #        project_name: "Marketing Materials",
    #        source_language: "eng-US",
    #        target_language: "spa-ES",
    #        price_currency: "usd",
    #        price_amount: 11.22,
    #        due_at: "2014-10-13T11:56:02-04:00",
    #        completed_at: "2014-10-09T12:11:06-04:00"
    #        created_at: "2014-10-09T11:56:02-04:00",
    #        operation: "text_translation",
    #        download_url: "https://api.verbalizeit.com/v2/tasks/TX1234/completed_file",
    #        source_download_url: "https://api.verbalizeit.com/v2/tasks/TX1234/source_file",
    #        source_filename: "marketing_materials.docx",
    #        unit_count: 66,
    #        unit_type: "word",
    #        translation_units: 16,
    #        translation_units_complete: 16,
    #        translator:{
    #          name: "Jenny S.",
    #          avatar: "http://assets.verbalizeit.com/..../translator.jpg"
    #        },
    #        reviewer:{
    #          name: "Stephen D.",
    #          avatar: "http://assets.verbalizeit.com/..../revewier.jpg"
    #        }
    #      }
    #    ]
    #
    #  }
    def tasks(options={})
      get("/#{api_version}/tasks.json", options)
    end

    ##
    # Show task status
    #
    # @param  [String]    task_id
    # @return [Hash]      Status: 201 OK
    #      {
    #        id: "TX1234",
    #        url: "http://localhost.verbalizeit.com:3000/v2/tasks/TCAAA"
    #        status: "complete",
    #        rush_order: false,
    #        project_name: "Marketing Materials",
    #        source_language: "eng-US",
    #        target_language: "spa-ES",
    #        price_currency: "usd",
    #        price_amount: 11.22,
    #        due_at: "2014-10-13T11:56:02-04:00",
    #        completed_at: "2014-10-09T12:11:06-04:00"
    #        created_at: "2014-10-09T11:56:02-04:00",
    #        operation: "text_translation",
    #        download_url: "https://api.verbalizeit.com/v2/tasks/TX1234/completed_file",
    #        source_download_url: "https://api.verbalizeit.com/v2/tasks/TX1234/source_file",
    #        source_filename: "marketing_materials.docx",
    #        unit_count: 66,
    #        unit_type: "word",
    #        translation_units: 16,
    #        translation_units_complete: 16,
    #        translator:{
    #          name: "Jenny S.",
    #          avatar: "http://assets.verbalizeit.com/..../translator.jpg"
    #        },
    #        reviewer:{
    #          name: "Stephen D.",
    #          avatar: "http://assets.verbalizeit.com/..../revewier.jpg"
    #        }
    #      }
    def task_status(task_id)
      get("/#{api_version}/tasks/#{task_id}.json")
    end

    ##
    # Create a new task
    #
    # @param  [String]    operation         Operation to perform (text_translation, audio_transcription, video_transcription)
    # @param  [String]    source_language   Language/Region code of original input media
    # @param  [String]    target_language   Language/Region code of final output media
    # @param  [Options]   file
    # @param  [Options]   media_resource_url
    # @param  [Options]   post_back_url
    # @param  [Options]   status_url
    # @param  [Options]   start
    # @param  [Options]   rush_order
    #
    # @return [Hash]      Status: 201 OK
    #      {
    #        id: "TX1234",
    #        url: "http://localhost.verbalizeit.com:3000/v2/tasks/TCAAA"
    #        status: "complete",
    #        rush_order: false,
    #        project_name: "Marketing Materials",
    #        source_language: "eng-US",
    #        target_language: "spa-ES",
    #        price_currency: "usd",
    #        price_amount: 11.22,
    #        due_at: "2014-10-13T11:56:02-04:00",
    #        completed_at: "2014-10-09T12:11:06-04:00"
    #        created_at: "2014-10-09T11:56:02-04:00",
    #        operation: "text_translation",
    #        download_url: "https://api.verbalizeit.com/v2/tasks/TX1234/completed_file",
    #        source_download_url: "https://api.verbalizeit.com/v2/tasks/TX1234/source_file",
    #        source_filename: "marketing_materials.docx",
    #        unit_count: 66,
    #        unit_type: "word",
    #        translation_units: 16,
    #        translation_units_complete: 16,
    #        translator:{
    #          name: "Jenny S.",
    #          avatar: "http://assets.verbalizeit.com/..../translator.jpg"
    #        },
    #        reviewer:{
    #          name: "Stephen D.",
    #          avatar: "http://assets.verbalizeit.com/..../revewier.jpg"
    #        }
    #      }
    def create_task(operation, source_language, target_language, options)
      opts = { operation: operation, source_language: source_language, target_language: target_language }
      post("/#{api_version}/tasks.json", opts.merge(options))
    end

    ##
    # Start a task in preview state. This kicks off work by VerbalizeIt and the translator community.
    #
    # @param  [String]    task_id
    # @return [NA]        Status: 200 OK
    def start_task(task_id)
      post("/#{api_version}/tasks/#{task_id}/start.json")
    end

    ##
    # Download a completed file. Task must be in the complete state.
    #
    # @param  [String]    task_id
    # @return [String]    File download   Status: 200 OK
    def download_completed_file(task_id)
      get("/#{api_version}/tasks/#{task_id}/completed_file.json")
    end

    private

    def get(path, options = {})
      opts = { query: options, timeout: timeout(options), headers: {"X-API-KEY" => api_key} }
      handle_response(self.class.get("#{api_url}#{path}", opts))
    end

    def post(path, options = {})
      opts = { body: options, timeout: timeout(options), headers: {"X-API-KEY" => api_key} }
      handle_response(self.class.post("#{api_url}#{path}", opts))
    end

    def timeout(options)
      timeout = options.delete(:timeout)
      timeout = 120 if timeout.nil?
      timeout
    end
  end
end
