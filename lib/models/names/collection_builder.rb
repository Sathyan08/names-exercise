require 'csv'

module Names
  class CollectionBuilder
    LAST_NAME_COLUMN = 0
    FIRST_NAME_COLUMN = 1

    def self.build(csv_file_path, unique_names_list_length = 25)
      name_collection = Names::Collection.new(unique_names_list_length)

      CSV.foreach(csv_file_path) do |row|
        first_name = row[FIRST_NAME_COLUMN].strip
        last_name = row[LAST_NAME_COLUMN].strip

        if first_name.present? && last_name.present?
          name = Names::Name.new(first_name, last_name)
          name_collection << name
        end
      end

      name_collection
    end
  end
end
