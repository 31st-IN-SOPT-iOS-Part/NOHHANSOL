//
//  SortedMusicModel.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/11/16.
//

import Foundation

// MARK: - SortedMusicModel

struct SortedMusicModel {
    var singer: String
    var musicList: [MusicModel]
}

// MARK: - Extension

extension SortedMusicModel {
    static var sampleData: [SortedMusicModel] =
    [
        SortedMusicModel(singer: "IU",
                         musicList: [MusicModel(albumImage: "imageAlbumIU1", title: "밤편지", singer: "IU"),
                                     MusicModel(albumImage: "imageAlbumIU2", title: "삐삐", singer: "IU"),
                                     MusicModel(albumImage: "imageAlbumIU3", title: "Strawberry Moon", singer: "IU"),
                                     MusicModel(albumImage: "imageAlbumIU4", title: "Celebrity", singer: "IU"),
                                     MusicModel(albumImage: "imageAlbumIU5", title: "분홍신", singer: "IU"),
                                     MusicModel(albumImage: "imageAlbumIU5", title: "분홍신", singer: "IU"),
                                     MusicModel(albumImage: "imageAlbumIU5", title: "분홍신", singer: "IU"),
                                     MusicModel(albumImage: "imageAlbumIU6", title: "LILAC", singer: "IU")]),
        SortedMusicModel(singer: "Crush",
                         musicList: [MusicModel(albumImage: "imageAlbumCrush1", title: "SOFA", singer: "Crush"),
                                     MusicModel(albumImage: "imageAlbumCrush2", title: "가끔", singer: "Crush"),
                                     MusicModel(albumImage: "imageAlbumCrush3", title: "잊어버리지마", singer: "Crush"),
                                     MusicModel(albumImage: "imageAlbumCrush4", title: "Rush Hour", singer: "Crush"),
                                     MusicModel(albumImage: "imageAlbumCrush5", title: "Beautiful", singer: "Crush"),
                                     MusicModel(albumImage: "imageAlbumCrush5", title: "Beautiful", singer: "Crush"),
                                     MusicModel(albumImage: "imageAlbumCrush5", title: "Beautiful", singer: "Crush"),
                                     MusicModel(albumImage: "imageAlbumCrush6", title: "Oasis", singer: "Crush")]),
        SortedMusicModel(singer: "IVE",
                         musicList: [MusicModel(albumImage: "imageAlbumIVE1", title: "Eleven", singer: "IVE"),
                                     MusicModel(albumImage: "imageAlbumIVE2", title: "After LIKE", singer: "IVE"),
                                     MusicModel(albumImage: "imageAlbumIVE3", title: "LOVE DIVE", singer: "IVE")])
    ]
}
