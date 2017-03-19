module Names
  class Collection
    attr_reader :unique_names_list_length

    def question_answers
      @question_answers ||= Names::Answers.new(
                                                unique_full_names_registry: unique_full_names_registry,
                                                first_name_registry: first_name_registry,
                                                last_name_registry: last_name_registry,
                                                completely_unique_name_registry: completely_unique_name_registry,
                                                unique_names_list_length: unique_names_list_length
                                              )
    end

    def <<(name)
      raise ArgumentError unless name.is_a?(Names::Name)

      unique_full_names_registry << name.full_name

      first_name_registry[name.first_name] += 1
      last_name_registry[name.last_name] += 1

      completely_unique_name_registry << name if should_register_as_completely_unique?(name)

      # This returns self to provide similar output to the array shovel operator, which returns the array itself.
      self
    end

    private

    def initialize(unique_names_list_length = 25)
      @unique_names_list_length = unique_names_list_length
    end

    def unique_full_names_registry
      @unique_full_names_registry ||= Set.new
    end

    def first_name_registry
      @first_name_registry ||= Hash.new(0)
    end

    def last_name_registry
      @last_name_registry ||= Hash.new(0)
    end

    def completely_unique_name_registry
      @unique_name_registry ||= Set.new
    end

    def should_register_as_completely_unique?(name)
      completely_unique_name_registry.count < unique_names_list_length && completely_unique_name?(name)
    end

    def completely_unique_name?(name)
      first_name_registry[name.first_name] == 1 && last_name_registry[name.last_name] == 1
    end
  end
end
