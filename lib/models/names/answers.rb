module Names
  class Answers
    attr_reader :unique_full_names_registry, :first_name_registry, :last_name_registry, :completely_unique_name_registry, :unique_names_list_length

    # This constant is 40 underscores to separate the answer header from the actual answer
    HEADER_ANSWER_DIVIDING_LINE = '_' * 40

    # This constant adds lines between the answers to make them easier to read
    ANSWER_TAIL = ['', '']

    delegate :each, to: :formatted_answers_collection

    private

    def initialize(unique_full_names_registry:, first_name_registry:, last_name_registry:, completely_unique_name_registry:, unique_names_list_length:)
      @unique_full_names_registry = unique_full_names_registry
      @first_name_registry = first_name_registry.sort_by(&:last)
      @last_name_registry = last_name_registry.sort_by(&:last)
      @completely_unique_name_registry = completely_unique_name_registry
      @unique_names_list_length = unique_names_list_length
    end

    def formatted_answers_collection
      answers_collection.each_with_index.map { |answer, index| formatted_answer(answer, index)  }
    end

    def formatted_answer(answer, index)
      question_number = index + 1
      question_line = "#{question_number}. #{answer.header}"
      answers = Array.wrap(answer.answers)

      [question_line, HEADER_ANSWER_DIVIDING_LINE] + answers + ANSWER_TAIL
    end

    def answers_collection
      @answers_collection ||= [
        unique_full_names_count_answer,
        unique_last_names_count_answer,
        unique_first_names_count_answer,
        ten_most_common_last_names_answer,
        ten_most_common_first_names_answer,
        completely_unique_names_answer,
        modified_names_answer
      ]
    end

    def unique_full_names_count_answer
      @unique_full_names_count_answer ||= Hashie::Mash.new({
        header: "The unique count of full names is:",
        answers: unique_full_names_registry.count
        })
    end

    def unique_last_names_count_answer
      @unique_last_names_count_answer ||= Hashie::Mash.new({
        header: "The unique count of last names is:",
        answers: last_name_registry.count
        })
    end

    def unique_first_names_count_answer
      @unique_first_names_count_answer ||= Hashie::Mash.new({
        header: "The unique count of first names is:",
        answers: first_name_registry.count
        })
    end

    def ten_most_common_last_names_answer
      @ten_most_common_last_names_answer ||= Hashie::Mash.new({
        header: "The ten most common last names are:",
        answers: last_name_registry.last(10).map { |name, count| name_and_count(name, count) }
        })
    end

    def ten_most_common_first_names_answer
      @ten_most_common_first_names_answer ||= Hashie::Mash.new({
        header: "The ten most common first names are:",
        answers: first_name_registry.last(10).map { |name, count| name_and_count(name, count) }
        })
    end

    def completely_unique_names_answer
      @completely_unique_names_answer ||= Hashie::Mash.new({
        header: "The first #{unique_names_list_length} completely unique names are:",
        answers: completely_unique_name_registry.map(&:display_name)
        })
    end

    def modified_names_answer
      @modified_names_answer ||= Hashie::Mash.new({
        header: "The modified names are:",
        answers: modified_names.map(&:display_name)
        })
    end

    def name_and_count(name, count)
      "#{name}, #{count}"
    end

    def modified_names
       unique_first_names = completely_unique_name_registry.map(&:first_name)
       unique_last_names = completely_unique_name_registry.map(&:last_name)

       unique_modified_full_names = unique_first_names.zip(unique_last_names.reverse)
       unique_modified_full_names.map { |first_name, last_name| Names::Name.new(first_name, last_name) }
    end
  end
end
