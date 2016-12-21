//: Playground - noun: a place where people can play

import UIKit

let contentText = "#NowPlaying Paradise By the Dashboard Light by Meat Loaf "
let index = contentText.index(contentText.startIndex, offsetBy: 12)
let fullTitle = contentText.substring(from: index)
var splitted = fullTitle.components(separatedBy: " by ")

let urlString = "https://open.spotify.com/track/2xMBf5lFjQvrkWL2toULNg"
let url = URL(string: urlString)
if let components = url?.path.components(separatedBy: "/") {
    let type = components[1]
    let id = components[2]
    let uri = "spotify:\(type):\(id)"
}
