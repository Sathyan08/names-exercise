module Names
  class Collection
    attr_reader :unique_names_list_length

    def question_answers
      @question_answers ||= Names::Answers.new(self)
    end

    def <<(name)
      raise ArgumentError unless name.is_a?(Names::Name)

      unique_full_names_registry << name.full_name

      first_name_registry[name.first_name] += 1
      last_name_registry[name.last_name] += 1

      completely_unique_name_registry << name if completely_unique_name?(name)

      # This returns self to provide similar output to the array shovel operator, which returns the array itself.
      self
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

    private

    def initialize(unique_names_list_length = 25)
      @unique_names_list_length = unique_names_list_length
    end

    def completely_unique_name?(name)
      first_name_registry[name.first_name] == 1 && last_name_registry[name.last_name] == 1
    end
  end
end
