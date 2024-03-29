# frozen_string_literal: true

module Gpt3
  module Builder
    class FileBuilder
      include KLog::Logging

      attr_reader :client

      # List fine-tunes
      # List your organization's fine-tuning jobs
      # https://api.openai.com/v1/fine-tunes
      # {
      #   "object": "list",
      #   "data": [
      #     {
      #       "id": "ft-AF1WoRqd3aJAHsqc9NY7iL8F",
      #       "object": "fine-tune",
      #       "model": "curie",
      #       "created_at": 1614807352,
      #       "fine_tuned_model": null,
      #       "hyperparams": { ... },
      #       "organization_id": "org-...",
      #       "result_files": [],
      #       "status": "pending",
      #       "validation_files": [],
      #       "training_files": [ { ... } ],
      #       "updated_at": 1614807352,
      #     },
      #     { ... },
      #     { ... }
      #   ]
      # }

      # Retrieve fine-tune
      # Gets info about the fine-tune job.
      # https://api.openai.com/v1/fine-tunes/{fine_tune_id}
      # {
      #   "id": "ft-AF1WoRqd3aJAHsqc9NY7iL8F",
      #   "object": "fine-tune",
      #   "model": "curie",
      #   "created_at": 1614807352,
      #   "events": [
      #     {
      #       "object": "fine-tune-event",
      #       "created_at": 1614807352,
      #       "level": "info",
      #       "message": "Job enqueued. Waiting for jobs ahead to complete. Queue number: 0."
      #     },
      #     {
      #       "object": "fine-tune-event",
      #       "created_at": 1614807356,
      #       "level": "info",
      #       "message": "Job started."
      #     },
      #     {
      #       "object": "fine-tune-event",
      #       "created_at": 1614807861,
      #       "level": "info",
      #       "message": "Uploaded snapshot: curie:ft-acmeco-2021-03-03-21-44-20."
      #     },
      #     {
      #       "object": "fine-tune-event",
      #       "created_at": 1614807864,
      #       "level": "info",
      #       "message": "Uploaded result files: file-QQm6ZpqdNwAaVC3aSz5sWwLT."
      #     },
      #     {
      #       "object": "fine-tune-event",
      #       "created_at": 1614807864,
      #       "level": "info",
      #       "message": "Job succeeded."
      #     }
      #   ],
      #   "fine_tuned_model": "curie:ft-acmeco-2021-03-03-21-44-20",
      #   "hyperparams": {
      #     "batch_size": 4,
      #     "learning_rate_multiplier": 0.1,
      #     "n_epochs": 4,
      #     "prompt_loss_weight": 0.1,
      #   },
      #   "organization_id": "org-...",
      #   "result_files": [
      #     {
      #       "id": "file-QQm6ZpqdNwAaVC3aSz5sWwLT",
      #       "object": "file",
      #       "bytes": 81509,
      #       "created_at": 1614807863,
      #       "filename": "compiled_results.csv",
      #       "purpose": "fine-tune-results"
      #     }
      #   ],
      #   "status": "succeeded",
      #   "validation_files": [],
      #   "training_files": [
      #     {
      #       "id": "file-XGinujblHPwGLSztz8cPS8XY",
      #       "object": "file",
      #       "bytes": 1547276,
      #       "created_at": 1610062281,
      #       "filename": "my-data-train.jsonl",
      #       "purpose": "fine-tune-train"
      #     }
      #   ],
      #   "updated_at": 1614807865,
      # }
    end
  end
end
