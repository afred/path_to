require 'spec_helper'

describe PathTo do

  before do
    # Paths to test files
    @test_files = [
      './spec/example_files/dir_1/alpha',
      './spec/example_files/dir_2/alpha',
      './spec/example_files/dir_2/bravo'
    ]

    # Get the directories of the test files for convenience.
    @test_dirs = @test_files.map{ |test_file| File.dirname(test_file) }.uniq

    # Create the test directories.
    @test_dirs.each{ |test_dir| `mkdir -p #{test_dir}` }

    # Create the test files.
    @test_files.each { |test_file| `touch #{test_file} && echo "example file: #{test_file}" > #{test_file}` }
  end

  after do
    # Remove the test files and test dirs
    FileUtils.rm @test_files
    FileUtils.rmdir @test_dirs.push('./spec/example_files')
  end

  let(:path_to) do
    # The order of the paths in the constructor becomes the order of precedent
    PathTo.new(*@test_dirs)
  end

  describe '#path_to' do

    context 'when file exists in path with higher precedent AND in path with lower precedent' do
      it 'returns the file path with higher precedent' do
        expect(path_to.path_to('alpha')).to eq "./spec/example_files/dir_1/alpha"
      end
    end

    context 'when file exists in path with lower precedent but NOT in path with higher precedent' do
      it 'returns the file path with lower precedent' do
        expect(path_to.path_to('bravo')).to eq "./spec/example_files/dir_2/bravo"
      end
    end

    context 'when file does not exist an any of the path' do
      it 'returns nil' do
        expect(path_to.path_to('does-not-exist')).to eq nil
      end
    end
  end

  describe '#paths_to' do
    it 'applies #path_to (singular) to each element of the first argument, and returns the resulting array' do
      expect(path_to.paths_to(['alpha', 'bravo', 'does-not-exist'])).to eq ['./spec/example_files/dir_1/alpha', './spec/example_files/dir_2/bravo', nil]
    end

    context 'when only a single value is given' do
      it 'still returns an array' do
        expect(path_to.paths_to('does-not-exist')).to eq [nil]
      end
    end
  end

  describe '#file' do
    it "same as #path_to, but returns a File object instad of just the path." do
      file = path_to.file('alpha')
      expect(file).to be_a File
      expect(file.path).to eq path_to.path_to('alpha')
    end
  end

  describe '#paths' do
    it 'returns an array of all paths' do
      expect(path_to.paths).to eq ['./spec/example_files/dir_1', './spec/example_files/dir_2']
    end
  end
end