class GenerateOutputFile

  def execute(input_file_path, output_file_path, unique_names_list_length)
    name_collection = Names::CollectionBuilder.build(input_file_path, unique_names_list_length)

    File.open(output_file_path, 'wb') do |file|
      name_collection.question_answers.each do |question_answer|
        file.puts(question_answer)
      end
    end
  end
end
