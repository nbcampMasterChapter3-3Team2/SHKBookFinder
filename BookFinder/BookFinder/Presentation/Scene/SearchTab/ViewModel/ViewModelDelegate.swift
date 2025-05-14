//
//  SearchTabViewModelDelegate.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import RxSwift

protocol ViewModelDelegate: AnyObject {
    associatedtype Action
    associatedtype State

    var action: ((Action) -> Void)? { get }
    var disposeBag: DisposeBag { get }
}
