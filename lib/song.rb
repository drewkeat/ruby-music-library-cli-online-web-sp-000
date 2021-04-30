require 'pry'
class Song
    attr_accessor :name, :artist, :genre
    @@all = []
    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist != nil
        self.genre = genre if genre != nil
        
    end

    def self.create(name)
        self.new(name).tap {|song| song.save}
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def self.find_by_name(name)
        all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) ? find_by_name(name) : create(name)
    end

    def self.new_from_filename(filename)
        name = filename.split(" - ")[1]
        artist_name = filename.split(" - ")[0]
        genre_name = filename.split(" - ")[2].gsub(".mp3","")
    
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)

        self.new(name, artist, genre)
        # binding.pry
    end

    def self.create_from_filename(filename)
        new_from_filename(filename).tap {|song| song.save}
    end
end