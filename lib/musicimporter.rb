require 'pry'
class MusicImporter
    attr_accessor :path

    def initialize(file_path)
        @path = file_path
    end

    def files
        array = Dir["#{self.path}/*"]
        array.map! {|str| str.gsub("#{self.path}/","")}
        # binding.pry
    end

    def import
        files.each {|fname| Song.create_from_filename(fname)}
    end
end