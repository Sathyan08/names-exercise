module Names
  class Name
    attr_reader :first_name, :last_name

    def full_name
      "#{first_name} #{last_name}"
    end

    def display_name
      "#{last_name}, #{first_name}"
    end

    private

    def initialize(first_name, last_name)
      raise ArgumentError unless first_name.present? && last_name.present?
      @first_name = first_name
      @last_name = last_name
    end
  end
end
