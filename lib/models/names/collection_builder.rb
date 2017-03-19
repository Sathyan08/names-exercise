module Names
  class CollectionBuilder
    LAST_NAME_COLUMN = 0
    FIRST_NAME_COLUMN = 1
    LETTERS_REGEX = /[a-zA-Z]/
    NON_LETTERS_REGEX = /[^a-zA-Z]/

    def self.build(file_path, unique_names_list_length = 25)
      name_collection = Names::Collection.new(unique_names_list_length)

      File.readlines(file_path).each do |line|
        # Checks to see if the line starts with a character that might be in a valid name.
        next unless LETTERS_REGEX.match(line[0]).present?

        # Take the first two words
        row = line.split(' ')
        first_name = row[FIRST_NAME_COLUMN].strip
        last_name = row[LAST_NAME_COLUMN].strip

        # Cuts off the commas off of the last name
        last_name = last_name[0..-2] if last_name.end_with?(',')

        # skips the line if the first two words contain any non-letter characters
        next if NON_LETTERS_REGEX.match(first_name) || NON_LETTERS_REGEX.match(last_name)

        if first_name.present? && last_name.present?
          name = Names::Name.new(first_name, last_name)
          name_collection << name
        end
      end

      name_collection
    end
  end
end
