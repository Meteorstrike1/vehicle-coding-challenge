describe FileHandler do
  include FileHandler

  it "won't accept the file" do
    file = 'spec/invalid_file.csv'
    expect { FileHandler.load_file_into_hash(file) }.to raise_error(Errors::InvalidFileFormat)
  end
end
