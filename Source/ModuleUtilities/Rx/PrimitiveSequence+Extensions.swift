//
//  PrimitiveSequence+Extensions.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation
import Moya
import XMLParsing
import RxCocoa
import RxSwift
import SVProgressHUD

extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {

    public func map<D: Decodable>(_ type: D.Type, using decoder: XMLDecoder = XMLDecoder()) -> Single<D> {
        return flatMap { .just(try decoder.decode(type, from: $0.data))}
    }
}

extension PrimitiveSequenceType where TraitType == SingleTrait {
    public func doWithLoader(onSuccess: ((ElementType) throws -> Void)? = nil,
                             onError: ((Swift.Error) throws -> Void)? = nil,
                             onSubscribe: (() -> Void)? = nil,
                             onSubscribed: (() -> Void)? = nil,
                             onDispose: (() -> Void)? = nil)
        -> Single<ElementType> {
            DispatchQueue.main.async {
                SVProgressHUD.show()
            }
            return self
                .do {
                    DispatchQueue.main.async {
                        SVProgressHUD.popActivity()
                    }
                }.do(
                    onSuccess: onSuccess,
                    onError: onError,
                    onSubscribe: onSubscribe,
                    onSubscribed: onSubscribed,
                    onDispose: onDispose)
    }

}
