//
//  DecoderManager.swift
//  ios_lib_UDNCCBotManager
//
//  Created by 羅翊修 on 2020/2/12.
//  Copyright © 2020 羅翊修. All rights reserved.
//

struct DecoderManager {

    static let decoder = JSONDecoder()

    static func toNewsModel(data: Data) -> NewsModel? {

        if let newsModel = try? decoder.decode(NewsModel.self, from: data ) {
            return newsModel
        } else {
            return nil
        }
    }
}
