//
//  CommunityPostsViewModel.swift
//  MoveOn
//
//  Created by 심주미 on 2022/02/10.
//

import Foundation
import RxSwift
import RxCocoa

class CommunityPostsViewModel {
    let disposeBag = DisposeBag()
    
    var postSubject = PublishSubject<[Post]>()
    //var postSectionSubject = PublishSubject<[CommunitySectionModel]>()
    init() {
        //populateTagPosts()
    }
    
    func populatePosts() {
        
        let userId = UserDefaults.standard.string(forKey: "userId")!
        let resource = Resource<[Post]>(url:URL( string:"http://ec2-3-34-56-36.ap-northeast-2.compute.amazonaws.com:8080/api/v1/posts/select?department-id=2&size=10&user-id=\(userId)")!, parameter: [:], header: [.authorization(bearerToken: KeyChainManager().read(service: "moveOn", account: "accessToken")!)], method: .get)
        
        API().load(resource: resource)
            .subscribe(onNext: { postsResponse in
                self.postSubject.onNext(postsResponse)
                //self.postSectionSubject.onNext(CommunitySectionModel.PostSection(items: [.PostItem( postsResponse.nickname, <#T##content: String##String#>)]))
            }).disposed(by: disposeBag)
    }
}
