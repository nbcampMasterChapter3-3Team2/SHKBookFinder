//
//  SearchTabViewModelDelegate.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import RxSwift
import RxRelay

protocol ViewModelType: AnyObject {
    associatedtype Action
    associatedtype State

    var action: PublishRelay<Action> { get }
    var state: State { get set }
}
