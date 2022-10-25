# frozen_string_literal: true

RSpec.describe Gpt3::Builder::Gpt3Builder do
  let(:instance) { described_class.init }
  let(:cfg) { ->(config) {} }

  # NOTE: Goals:
  # GPT3 Builder is really about prompt building
  # and example gathering and massaging.
  # prompts should allow user driven input
  #
  let(:max_tokens) { 50 }
  # Temperature represents variety
  # Here is a good example: https://beta.openai.com/docs/quickstart/adjust-your-settings
  # Higher values means the model will take more risks. Try 0.9 for more creative applications, and 0 for well-defined answer.
  let(:temperature) { 0 }
  # An alternative to sampling with temperature, called nucleus sampling,
  # where the model considers the results of the tokens with top_p probability mass.
  # So 0.1 means only the tokens comprising the top 10% probability mass are considered.
  # It is generally recommended alter top_p or temperature but not both.
  let(:top_p) { 1 }

  # NOT IMPLEMENTED in : How many completions to generate for each prompt.
  let(:n) { 1 }

  # NOT IMPLEMENTED in : Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
  let(:stop) { [] }

  let(:frequency_penalty) { 0 }
  let(:presence_penalty) { 0 }

  let(:fluent_commands) { ->(builder) {} }

  let(:test_path) { File.expand_path('~/dev/kgems/k_templates/templates/tailwind/tui/marketing/sections') }
  # let(:test_file) { File.join(test_path, test_sect, "#{test_name}.html") }

  # let(:prompt) { question }
  # let(:path) { 'spec/samples/inputs' }

  xdescribe '#initialize' do
    subject { instance }

    let(:instance) { described_class.new }

    it { is_expected.not_to be_nil }
  end

  xdescribe '#init' do
    subject { instance }

    it { is_expected.to be_a(described_class) }

    context 'with no configuration' do
      it do
        is_expected.to have_attributes(
          max_tokens: 50,
          temperature: 0,
          top_p: 1,
          frequency_penalty: 0,
          presence_penalty: 0,
          prompt: '',
          engine: 'davinci-codex'
        )
      end
      # code-davinci-002

      context '.access_token' do
        subject { instance.access_token }

        it { is_expected.not_to be_nil }
      end

      context '.client' do
        subject { instance.client }

        it { is_expected.not_to be_nil }
      end

      # DEAL with ENV['OPENAI_ACCESS_TOKEN'] vs ENV['OPENAI_SECRET_KEY']

      # context '.template_folders.folders' do
      #   subject { instance.template_folders.folders }

      #   it { is_expected.to be_empty }
      # end
    end
  end

  xdescribe '#prompt' do
    subject { instance.prompt }

    it { is_expected.to be_empty }
  end

  xdescribe '.client.models.list' do
    subject { instance.client.models.list }

    xit { puts subject['data'].map { |model| model['id'] } }
  end

  xcontext 'fluent API' do
    subject { run_commands.prompt }

    let(:run_commands) { fluent_commands.call(instance) }

    describe '#start' do
      let(:fluent_commands) do
        lambda do |builder|
          builder
            .start('Ruby chatbot')
        end
      end

      it { is_expected.to include('Ruby chatbot') }

      describe '#dude (alias of human)' do
        let(:fluent_commands) do
          lambda do |builder|
            builder
              .start('Ruby chatbot')
              .dude('Create a configuration class for the person table with the fields, First Name, Last Name and Date of Birth and three rows of sample data')
          end
        end

        it { is_expected.to include('You: Create a configuration class for the person table with the fields, First Name, Last Name and Date of Birth and three rows of sample data') }
      end

      describe '#human' do
        let(:fluent_commands) do
          lambda do |builder|
            builder
              .start('Ruby chatbot')
              .human('Create a configuration class for the person table with the fields, First Name, Last Name and Date of Birth and three rows of sample data')
          end
        end

        it { is_expected.to include('You: Create a configuration class for the person table with the fields, First Name, Last Name and Date of Birth and three rows of sample data') }

        describe '#example' do
          context 'with string based example' do
            let(:fluent_commands) do
              lambda do |builder|
                builder
                  .start('Ruby chatbot')
                  .human('Create a configuration class for the person table with the fields, First Name, Last Name and Date of Birth and three rows of sample data')
                  .example(file: 'spec/samples/example_class.rb')
              end
            end

            it { is_expected.to include('row "David", "Cruwys", 07/01/1990') }
          end
        end
      end

      describe '#message' do
        let(:component_type) { 'Call to Action' }
        let(:test_sect) { 'cta-sections' }
        let(:test_name) { '08' }

        let(:fluent_commands) do
          lambda do |builder|
            target = '08'
            tokens = 250

            builder
              .start("Extract JSON data from '#{component_type}' HTML component")
              .message('HTML:')
              .example(read_content(test_path, 'cta-sections', '02.html'))
              .message('JSON:')
              .example(read_content(test_path, 'cta-sections', '02.json'))
              .message('HTML:')
              .example(read_content(test_path, 'cta-sections', '03.html'))
              .message('JSON:')
              .example(read_content(test_path, 'cta-sections', '03.json'))
              .message('HTML:')
              .example(read_content(test_path, 'cta-sections', "#{target}.html"))
              .message('JSON:')
              .complete(engine: 'code-davinci-002', max_tokens: tokens, suffix: "\n")
              .write_result(content_path(test_path, 'cta-sections', "#{target}.json"))
          end
        end

        # fit { run_commands.debug }
        xit do
          run_commands.debug
        end
        # it { is_expected.to include('You: Create a configuration class for the person table with the fields, First Name, Last Name and Date of Birth and three rows of sample data') }
      end

      describe '#build upload file for fine tuning' do
        xit do
          training = [
            {
              prompt: read_content(test_path, 'cta-sections', '02.html', remove_class: false, remove_newline: true, squish: true),
              completion: read_content(test_path, 'cta-sections', '02.json', remove_newline: true, squish: true)
            },
            {
              prompt: read_content(test_path, 'cta-sections', '03.html', remove_class: false, remove_newline: true, squish: true),
              completion: read_content(test_path, 'cta-sections', '03.json', remove_newline: true, squish: true)
            }
          ]

          jsonl = training.map(&:to_json).join("\n")

          path = 'spec/samples/uploads'
          file = 'tailwind-component-to-json-data.jsonl'
          full_file = File.join(path, file)
          File.write(full_file, jsonl)

          response = instance.client.files.upload(parameters: { file: full_file, purpose: 'fine-tune' })
          puts response

          puts JSON.pretty_generate(response)
          puts "ID: #{response['id']}"

          # "id"=>"file-N4tcxA1fJmbKnpH8ofnv2cdG"
        end
        # it { is_expected.to include('You: Create a configuration class for the person table with the fields, First Name, Last Name and Date of Birth and three rows of sample data') }
      end
    end
  end

  xdescribe '#file_list' do
    subject { instance.client.files.list }

    it {
      puts subject
      # is_expected.to be_empty
    }
  end

  xdescribe '#fine_tune_list' do
    subject { instance.client.finetunes.list }

    it {
      puts subject
      # is_expected.to be_empty
    }
  end

  xdescribe '#fine_tune_create' do
    subject do
      instance.client.finetunes.create(parameters: {
                                         model: 'davinci',
                                         training_file: 'file-N4tcxA1fJmbKnpH8ofnv2cdG'
                                       })
    end

    it {
      puts subject
      # is_expected.to be_empty
    }
  end

  xdescribe '#fine_tune_cancel' do
    subject do
      instance.client.finetunes.cancel(id: '')
    end

    it {
      puts subject
      # is_expected.to be_empty
    }
  end

  def content_path(path, section, file_name)
    File.join(path, section, file_name)
  end

  def read_content(path, section, file_name, remove_class: true, remove_newline: false, squish: false, remove_html_comments: true)
    file = content_path(path, section, file_name)
    raw_content = File.read(file)

    clean_content(raw_content, remove_class: remove_class, remove_newline: remove_newline, squish: squish, remove_html_comments: remove_html_comments)
  end

  # rubocop:disable  Layout/LineLength
  def clean_content(content, remove_class: true, remove_newline: false, squish: false, remove_html_comments: false)
    # remove classes, then remove newlines, then remove extra spaces
    content = content.gsub(/ class=\s*"([^"]*?)"/, '') if remove_class
    content = content.gsub(/\r?\n/, '') if remove_newline
    content = content.squeeze(' ') if squish
    content = content.gsub(/<!--((.*)|[^<]*|[^!]*|[^-]*|[^>]*)-->/, '') if remove_html_comments

    content
      .gsub('Ac euismod vel sit maecenas id pellentesque eu sed consectetur. Malesuada adipiscing sagittis vel nulla nec.', 'Ac euismod vel sit maecenas id pellentesque eu sed consectetur.')
      .gsub('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Et, egestas tempus tellus etiam sed. Quam a scelerisque amet ullamcorper eu enim et fermentum, augue. Aliquet amet volutpat quisque ut interdum tincidunt duis.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    # .gsub(/\n/, ' ')
    # .gsub(/\s+/, ' ')
  end
  # rubocop:enable  Layout/LineLength

  describe '#samples' do
    xit 'sample' do
      example = <<-RUBY

      class Configuration
        table :person do
          columns [:first_name, :last_name, :date_of_birth]

          row "David", "Cruwys", 17/01/1972
          row "Sean", "Wallace", 29/05/1967
          row "Lisa", "Cudro", 01/12/1974
        end
      end

      RUBY

      instance
        .prompt('Ruby chatbot')
        .command(:you, 'Create a configuration class for the person table with the fields, First Name, Last Name and Date of Birth and three rows of sample data')
        .example(example)
        .execute
        .write_to('xyz.rb')
    end
  end
end
