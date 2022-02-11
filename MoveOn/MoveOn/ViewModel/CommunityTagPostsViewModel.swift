//
//  CommunityViewModel.swift
//  MoveOn
//
//  Created by 심주미 on 2022/02/08.
//

import Foundation
import RxSwift
import RxCocoa

class CommunityTagPostsViewModel {
    let disposeBag = DisposeBag()
    
    var tagPostSubject = PublishSubject<[TagPost]>()
    
    init() {
        
    }
    
    func populateTagPosts() {
        let resource = Resource<[TagPost]>(url:URL( string:"http://ec2-3-34-56-36.ap-northeast-2.compute.amazonaws.com:8080/api/v1/posts-tag-relationship/select?department-id=2&size=10")!, parameter: [:], header: [.authorization(bearerToken: KeyChainManager().read(service: "moveOn", account: "accessToken")!)], method: .get)
        API().load(resource: resource)
            .subscribe(onNext: { tagPostsResponse in
                self.tagPostSubject.onNext(tagPostsResponse)
            }).disposed(by: disposeBag)
    }
}
