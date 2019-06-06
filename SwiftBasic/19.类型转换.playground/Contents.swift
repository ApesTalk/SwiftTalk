import UIKit

// is  as

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    //注意：由于Swift的两端初始化
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}


let library = [
    Movie(name: "Casablanca", director: "Michael Crtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

// # 类型检查 is
var movieCount = 0
var songCount = 0
for item in library {
    if item is Movie {
        movieCount += 1
    }else if item is Song {
        songCount += 1
    }
}
print("Media libray contains \(movieCount) movies and \(songCount) songs")




// # 向下类型转换 用as?或as!向下类型转换为子类类型
//as?返回向下类型转换，转换失败返回nil
//as!强制类型转换，转换失败会抛运行时错误

for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    }else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}





// # Any和AnyObject的类型转换
// AnyObject 可以表示任何类类型的实例
// Any 可以表示任何类型，包括函数类型, 包括可选类型

var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("Hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({(name: String) -> String in "Hello, \(name)"})


for t in things {
    switch t {
    case 0 as Int:
        print("Zero as an Int")
    case 0 as Double:
        print("Zero as a Double")
    case let someInt as Int:
        print("an Integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a possitive double value of \(someDouble)")
    case is Double:
        print("some other double value that i don't want to print")
    case let someString as String:
        print("a string value of \(someString)")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}


//Any类型表示了任意类型的值，包括可选类型。如果你给显式声明的Any类型使用可选项，会产生警告
let opionalNumber: Int? = 3
things.append(opionalNumber)
things.append(opionalNumber as Any)//使用as运算符来显示地转换可选项为Any
