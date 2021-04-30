require 'pry'
class Artist
    extend Concerns::Findable
    attr_accessor :name
    @@all = []
    def initialize(name)
        @name = name
    end

    def self.create(name)
        self.new(name).tap {|artist| artist.save}
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

    def songs
        Song.all.select {|song| song.artist == self}
    end
    def add_song(song)
        song.artist = self if !song.artist
    end
    
    def genres
        songs.map{|song| song.genre}.uniq
        # binding.pry
    end


end