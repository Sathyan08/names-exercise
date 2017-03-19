class GenerateOutputFile

  def execute(input_file_path, output_file_path)
    name_collection = Names::CollectionBuilder.build(input_file_path)

    File.open(output_file_path, 'wb') do |file|
      name_collection.question_answers.each do |question_answer|
        # question_answer.each { |line| file << line }
        file.puts(question_answer)
      end
    end
  end
end
