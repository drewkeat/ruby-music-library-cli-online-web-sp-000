require 'pry'
class MusicLibraryController
    attr_accessor :songs, :artists, :genres

    def initialize(path = './db/mp3s')
        MusicImporter.new(path).import
        @songs = Song.all
        @artists = Artist.all
        @genres = Genre.all
    end

    def call
        valid_responses = [
            "list songs",
            "list artists",
            "list genres",
            "list artist",
            "list genre",
            "play song",
            "exit"
        ]

        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        input = gets.strip
        if !valid_responses.include?(input)
            self.call
        elsif input == "list songs"
            list_songs
        elsif input == "list artists"
            list_artists
        elsif input == "list genres"
            list_genres
        elsif input == "list artist"
            list_songs_by_artist
        elsif input == "list genre"
            list_songs_by_genre
        elsif input == "play song"
            play_song
        end


    end

    def list_songs
        sorted = @songs.sort_by {|song| song.name}
        sorted.each_with_index {|song, i| puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    end
    
    def list_artists
        sorted = @artists.sort_by {|artist| artist.name}
        sorted.each_with_index {|artist, i| puts "#{i + 1}. #{artist.name}"}
    end
    def list_genres
        sorted = @genres.sort_by {|genre| genre.name}
        sorted.each_with_index {|genre, i| puts "#{i + 1}. #{genre.name}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        request = gets.strip
        if Artist.find_by_name(request)
            list = Artist.find_by_name(request).songs
            list.sort_by! {|song| song.name}
            list.each_with_index {|song, i| puts "#{i + 1}. #{song.name} - #{song.genre.name}"}
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        request = gets.strip
        if Genre.find_by_name(request)
            list = Genre.find_by_name(request).songs
            list.sort_by! {|song| song.name}
            list.each_with_index {|song, i| puts "#{i + 1}. #{song.artist.name} - #{song.name}"}
        end
    end

    def play_song
        #   prompts the user to choose a song from the alphabetized list output by #list_songs (FAILED - 15)
        puts "Which song number would you like to play?"
        #   accepts user input (FAILED - 16)
        input = gets.strip
        if input.to_i.between?(1,@songs.length)
            selection = @songs.sort_by{|song| song.name}[input.to_i - 1]
            message = "Playing #{selection.name} by #{selection.artist.name}"
            puts message 
        end
    end
end