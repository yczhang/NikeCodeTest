//
//  DetailViewModel.swift
//  NikeAlbumTest
//
//  Created by YICHUN ZHANG on 1/6/21.
//

import Foundation

class DetailViewModel : NSObject
{
    var item : MusicItem?
    
    func getName()->String?
    {
        return item?.name
    }
    
    func getArtist()->String?
    {
        return item?.artistName
    }
    
    func getIconUrl()->String?
    {
        return item?.iconurl
    }
    
    func getITuneUrl()->String?
    {
        return item?.url
    }
    
    func getReleaseDate()->String?
    {
        return item?.releaseDate
    }
    
    func getCopyRight()->String?
    {
        return item?.copyright
    }
    
    func getGenres()->String?
    {
        var str = ""
        if let genres = item?.genres {
            
            for genre in genres
            {
                if str.count > 0 {str.append(",")}
                str.append(genre.name ?? "")
            }
            
        }
        return str
    }
}
