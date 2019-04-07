//
//  MoyaSugar.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Alamofire
import Moya
import RxSwift

open class MoyaSugar<Target: TargetType> {
    lazy var provider = MoyaProvider<Target>()
    private let disposeBag = DisposeBag()

    init(stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
         endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping) {

        let configuration = URLSessionConfiguration.default
        let serverTrustPolicies: [String: ServerTrustPolicy] =
            ["mobilefeeds.performgroup.com": .disableEvaluation]

        let manager = Manager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )

        provider = MoyaProvider<Target>(endpointClosure: endpointClosure,
                                        stubClosure: stubClosure,
                                        manager: manager,
                                        plugins: [])
    }
}
