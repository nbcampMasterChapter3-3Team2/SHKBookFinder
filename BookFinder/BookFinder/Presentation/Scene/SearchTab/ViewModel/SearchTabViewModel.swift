//
//  SearchTabViewModel.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import RxSwift
import RxRelay

final class SearchTabViewModel: ViewModelType {

    // MARK: - Action & State

    enum Action {
        case viewDidLoad
        case searchBookButtonTapped(String)
        case bookResultCellTapped(BookEntity)
        case loadNextPage
    }

    struct State {
        let bookResultSubject = BehaviorRelay<[BookEntity]>(value: [])
        let selectedBookSubject = PublishRelay<BookEntity>()
        let collectionViewSection = BehaviorRelay<[Section]>(value: [.searchResult])
        let recentBooksSubject = BehaviorRelay<[BookEntity]>(value: [])
        var isEnd: Bool = false
        var currentPage: Int = 1
        var currentQuery: String = ""
    }

    // MARK: - Properties

    private let bookUseCase: BookUseCase
    private let disposeBag = DisposeBag()

    var action = PublishRelay<Action>()
    var state = State()

    // MARK: - Initializer, Deinit, requiered

    init(
        bookUseCase: BookUseCase
    ) {
        self.bookUseCase = bookUseCase
        bindAction()
    }

    // MARK: - Methods

    private func bindAction() {
        action.bind { [weak self] action in
            guard let self else { return }
            switch action {
            case .viewDidLoad:
                fetchRecentBooks()
                configureSection()
            case .searchBookButtonTapped(let query):
                fetchSearchBookResult(query: query)
            case .bookResultCellTapped(let book):
                bookResultCellTapped(book)
                configureSection()
            case .loadNextPage:
                fetchNextPage()
            }
        }.disposed(by: disposeBag)
    }

    private func fetchNextPage() {
        guard !state.isEnd else { return }

        let query = state.currentQuery
        let nextPage = state.currentPage + 1

        bookUseCase.fetchSearchResultByPage(query: query, page: nextPage)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (newBooks, isEnd) in
                guard let self else { return }

                // 기존 값 + 새 페이지 결과 합치기
                let updatedBooks = self.state.bookResultSubject.value + newBooks
                self.state.bookResultSubject.accept(updatedBooks)

                // 페이징 상태 업데이트
                self.state.currentPage = nextPage
                self.state.isEnd = isEnd

            }, onFailure: { error in
                print("[Error] Fetch Next Page: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }

    private func configureSection() {
        var result: [Section] = []
        if !state.recentBooksSubject.value.isEmpty {
            result.append(.recentlyViewedBook)
        }
        result.append(.searchResult)

        state.collectionViewSection.accept(result)
    }

    private func fetchRecentBooks() {
        bookUseCase.fetchRecentBooks()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] books in
                guard let self else { return }
                state.recentBooksSubject.accept(books)
            }).disposed(by: disposeBag)
    }

    private func bookResultCellTapped(_ book: BookEntity) {
        // 선택된 셀의 BookEntity 업데이트
        state.selectedBookSubject.accept(book)

        // recentlyViewedBook Section 데이터 업데이트
        //   1. 선택된 셀의 BookEntity -> CoreData 에 추가
        //   2. update 된 모든 최근 본 책 fetch
        bookUseCase.addRecentBook(book)
            .andThen(bookUseCase.fetchRecentBooks())
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] books in
                guard let self else { return }
                state.recentBooksSubject.accept(books)
            }).disposed(by: disposeBag)
    }

    private func fetchSearchBookResult(query: String) {
        // TODO: 결과 체크 
//        bookUseCase.fetchSearchResult(query: quary)
//            .subscribe { [weak self] books in
//                guard let self else { return }
//                state.bookResultSubject.accept(books)
//            }.disposed(by: disposeBag)

        // 상태 초기화
        state.currentPage = 1
        state.isEnd = false
        state.currentQuery = query
        state.bookResultSubject.accept([]) // 이전 검색 결과 초기화

        // 첫 페이지 검색
        bookUseCase.fetchSearchResultByPage(query: query, page: 1)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (books, isEnd) in
                guard let self else { return }
                state.bookResultSubject.accept(books)
                state.isEnd = isEnd

                print(books)
            }, onFailure: { error in
                print("[Error] Search Book by Page: \(error.localizedDescription)")
            }).disposed(by: disposeBag)
    }
}
