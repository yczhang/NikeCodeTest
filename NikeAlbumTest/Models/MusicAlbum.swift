//
//  AlbumItem.swift
//  NikeAlbumTest
//
//  Created by YICHUN ZHANG on 1/6/21.
//

import Foundation

struct MusicAlbum: Codable
{
    let feed : MusicFeed?
}

struct MusicFeed: Codable
{
    let results : [MusicItem]?
}

struct MusicItem: Codable
{
    let name : String?
    let artistName: String?
    let iconurl: String?
    let url: String?
    let copyright: String?
    let releaseDate: String?
    let genres: [MusicGenre]?
    
    enum CodingKeys:String , CodingKey {
        case name
        case artistName
        case iconurl = "artworkUrl100"
        case url
        case copyright
        case releaseDate
        case genres
    }
}

struct MusicGenre: Codable
{
    let name: String?
}

