//
//  CommunitySectionModel.swift
//  MoveOn
//
//  Created by 심주미 on 2022/02/10.
//
/*
import Foundation
import RxDataSources

enum CommunitySectionModel {
    case TagSection(items:[SectionItem])
    case PostSection(items:[SectionItem])
}

enum SectionItem {
    case TagItem(_ content: String)   //태그 이름
    case PostItem(_ nickname: String, _ content:String)
}

extension CommunitySectionModel: SectionModelType {
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch self {
        case .TagSection(items: let items):
            return items.map{$0}
        case .PostSection(items: let items):
            return items.map{$0}
        }
    }
    
    init(original: CommunitySectionModel, items: [SectionItem]) {
        switch original {
        case .TagSection(let items):
            self = .TagSection(items: items)
        case .PostSection(let items):
            self = .PostSection(items: items)
        }
    }
    
}
*/
