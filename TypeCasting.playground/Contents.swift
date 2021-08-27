import Foundation

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Rick Astley")
]

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

movieCount
songCount

for item in library {
    if let movie = item as? Movie {
        print(movie.director)
    } else if let song = item as? Song {
        print(song.artist)
    }
}
