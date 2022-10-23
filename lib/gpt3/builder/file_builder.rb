# frozen_string_literal: true

module Gpt3
  module Builder
    class FileBuilder
      include KLog::Logging

      attr_reader :client

      # List of files
      # OpenAI::Client.new.files.list
      # r["data"]
      # or
      # r["data"][0]["filename"]

      # {
      #   "data": [
      #     {
      #       "id": "file-ccdDZrC3iZVNiQVeEA6Z66wf",
      #       "object": "file",
      #       "bytes": 175,
      #       "created_at": 1613677385,
      #       "filename": "train.jsonl",
      #       "purpose": "search"
      #     },
      #     {
      #       "id": "file-XjGxS3KTG0uNmNOK362iJua3",
      #       "object": "file",
      #       "bytes": 140,
      #       "created_at": 1613779121,
      #       "filename": "puppy.jsonl",
      #       "purpose": "search"
      #     }
      #   ],
      #   "object": "list"
      # }

      # Upload a file
      # purpose = 'answers'
      # response = OpenAI::Client.new.files.upload(parameters: { file: file, purpose: purpose })
      # r = JSON.parse(response.body)
      # r["filename"]
      # {
      #   "id": "file-XjGxS3KTG0uNmNOK362iJua3",
      #   "object": "file",
      #   "bytes": 140,
      #   "created_at": 1613779121,
      #   "filename": "mydata.jsonl",
      #   "purpose": "fine-tune"
      # }

      # Retrieve a file
      # response = OpenAI::Client.new.files.retrieve(id: id) }
      # r = JSON.parse(response.body)
      # r["data"]["filename"]
      # {
      #   "id": "file-XjGxS3KTG0uNmNOK362iJua3",
      #   "object": "file",
      #   "bytes": 140,
      #   "created_at": 1613779657,
      #   "filename": "mydata.jsonl",
      #   "purpose": "fine-tune"
      # }

      # Delete a file
      # response = OpenAI::Client.new.files.delete(id: id)
      # r = JSON.parse(response.body)
      # r["data"]["id"]
      # r["data"]["deleted"]
      # {
      #   "id": "file-XjGxS3KTG0uNmNOK362iJua3",
      #   "object": "file",
      #   "deleted": true
      # }

    end
  end
end
