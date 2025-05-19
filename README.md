# 📱 Book Finder App
책을 검색하고 저장하는 앱으로, CoreData + Clean Architecture 구조 및 RxSwift 를 학습하는 데 초점을 둔 프로젝트입니다.



## 프로젝트 개요

* **프로젝트 기간**: 2025년 5월 9일 ~ 5월 19일
* **프로젝트 구분**: 심화주차 개인 프로젝트
* **UI 구성 및 레이아웃**: `Swift` · `UIKit` · `SnapKit` · `Then`
* **아키텍처 및 설계 패턴**: `Clean Architecture` · `MVVM` · `DIContainer` 기반
* **데이터 흐름 관리**: `RxSwift` · `Action-State` 기반 설계
* **비즈니스 로직 처리**: `UseCase` 계층화, `Repository` 패턴, `CoreData` + `REST API` 병합


## 학습 목표

* `UIKit` 코드 기반 UI 설계 및 `AutoLayout` 대응
* `SnapKit`을 통한 다양한 디바이스 대응 레이아웃 구현
* `REST API` 연동 및 JSON 디코딩
* `MVVM` + `클린 아키텍처` 설계 기반 `View`/`ViewModel` 분리
* `Rx` + `Action-State` 기반 데이터 통신
* `CoreData` 기반 로컬 저장 및 즐겨찾기 기능
* `RxSwift` 기반 무한 스크롤 구현 및 상태 반응 설계
* 의존성 주입(`DIContainer`) 및 계층별 관심사 분리 구조 설계


## 주요 기능

| 기능 구분   | 세부 설명                                           |
| ------- | ----------------------------------------------- |
| 책 검색    | Kakao 책 검색 API 사용, 키워드 기반 검색 구현                 |
| 상세 보기   | 검색된 책 탭 시 상세 정보 표시 (모달)                         |
| 담기 기능   | CoreData를 활용한 즐겨찾기 책 저장 및 삭제                    |
| 최근 본 책  | 최근 상세 조회한 책 10권을 상단 섹션에 별도 표시                   |
| 무한 스크롤  | 다음 페이지 존재 시 자동 요청 (Rx 기반)                       |
| 클린 아키텍처 | UseCase, Repository, ViewModel, View 계층 분리      |
| 메모리 디버깅 | Instruments, Debugger 등으로 순환 참조 제거 및 메모리 최적화 수행 |


## 폴더 구조

```bash
BookFinder/
├── Application/
│   ├── Coordinator/
│   │   └── Coordinator.swift
│   ├── DIContainer/
│   │   ├── DIContainer.swift
│   │   ├── DiContainer+DataSource.swift
│   │   ├── DiContainer+Repository.swift
│   │   ├── DiContainer+UseCase.swift
│   │   ├── DiContainer+ViewController.swift
│   │   └── DiContainer+ViewModel.swift
│   ├── AppAPIKeys.swift
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
│
├── Data/
│   ├── Error/
│   │   └── Error.swift
│   ├── Mapper/
│   │   └── BookResponseMapper.swift
│   ├── Model/
│   │   ├── BookResponse.swift
│   │   ├── MetaResponse.swift
│   │   └── Persistence/
│   │       ├── Book+CoreDataClass.swift
│   │       ├── Book+CoreDataProperties.swift
│   │       ├── MyBook+CoreDataClass.swift
│   │       ├── MyBook+CoreDataProperties.swift
│   │       ├── RecentlyViewedBook+CoreDataClass.swift
│   │       ├── RecentlyViewedBook+CoreDataProperties.swift
│   │       └── BookFinder.xcdatamodeld
│   ├── Repository/
│   │   └── DefaultBookRepository.swift
│   └── Source/
│       ├── Local/
│       │   ├── BookLocalDataSource.swift
│       │   └── PersistenceController.swift
│       └── Remote/
│           └── BookAPIDataSource.swift
│
├── Domain/
│   ├── Entity/
│   │   ├── BookEntity.swift
│   │   └── MyBookEntity.swift
│   ├── Protocol/
│   │   ├── Repository/
│   │   │   └── BookRepository.swift
│   │   └── UseCase/
│   │       └── BookUseCase.swift
│   └── UseCase/
│       └── DefaultBookUseCase.swift
│
├── Presentation/
│   ├── Scene/
│   │   ├── Common/
│   │   │   └── ViewModelType.swift
│   │   ├── MyBookTab/
│   │   │   ├── SubView/
│   │   │   │   ├── MyBookCell.swift
│   │   │   │   └── MyBookCollectionView.swift
│   │   │   ├── ViewController/
│   │   │   │   ├── MyBookViewController.swift
│   │   │   │   └── MyBookViewController+Delegate.swift
│   │   │   └── ViewModel/
│   │   │       └── MyBookViewModel.swift
│   │   ├── SearchTab/
│   │   │   ├── Enum/
│   │   │   │   └── Section.swift
│   │   │   ├── SubView/
│   │   │   │   ├── HeaderView.swift
│   │   │   │   ├── RecentlyViewdBookCell.swift
│   │   │   │   ├── SearchCollectionView.swift
│   │   │   │   ├── SearchResultCell.swift
│   │   │   │   └── SearchResultDetailView.swift
│   │   │   ├── ViewController/
│   │   │   │   ├── SearchResultDetailViewController.swift
│   │   │   │   ├── SearchResultDetailViewController+Delegate.swift
│   │   │   │   ├── SearchTabViewController.swift
│   │   │   │   ├── SearchTabViewController+DataSource.swift
│   │   │   │   └── SearchTabViewController+Delegate.swift
│   │   │   └── ViewModel/
│   │   │       ├── SearchResultDetailViewModel.swift
│   │   │       ├── SearchResultDetailViewModelDelegate.swift
│   │   │       └── SearchTabViewModel.swift
│   │   └── TabBar/
│   │       └── TabBarController.swift
│   └── Resource/
│       ├── Assets.xcassets
│       ├── Info.plist
│       └── LaunchScreen.storyboard
```



## 트러블슈팅 사례

### 📍 특정 섹션의 헤더를 숨기고 싶을 때

* 문제: `UICollectionView`에서 "최근 검색 결과" 섹션의 헤더를 조건에 따라 숨기고 싶었음
* 조건: "최근 검색 결과" 섹션에 binding 되어있는 `BehaviorRelay`에 값이 not isEmpty 이면, 섹션을 보이고 데이터 표시
* 해결 방법 2가지 중 1번을 채택함:
  
  #### ✅ 채택한 방법: `Section` 배열 자체를 변경하여 아예 섹션을 삭제
  
    ```swift
    struct State {
        let collectionViewSection = BehaviorRelay<[Section]>(value: [.searchResult])
    }
    ```
    ```swift
    private func configureSection() {
        var result: [Section] = []
        if !state.recentBooksSubject.value.isEmpty {
            result.append(.recentlyViewedBook)
        }
        result.append(.searchResult)

        state.collectionViewSection.accept(result)
    }
    ```
  
  * **장점**:
  
    * 불필요한 섹션 및 헤더를 로직상에서 깔끔하게 제거 가능
    * 불필요한 조건 분기 없이 `UICollectionViewDataSource`가 자연스럽게 일관된 섹션 구조를 유지함
    * 순서 변경 시 확장성이 좋음
  
  #### ❎ 대안 방법 (채택하지 않음): UIStackView에 CollectionView를 두고 숨김 처리
  
  * StackView로 구성하고, 특정 섹션에 해당하는 CollectionView 자체를 `isHidden = true`로 설정하는 방법도 있음

<br>

### 📍 모달 뷰에서 값이 보이지 않는 문제 (VC 간 통신 이슈)

* 문제: `SearchResultDetailViewController`에서 상세 책 정보가 화면에 표시되지 않음
* 원인 1: `bind()` 메서드 호출 시점이 `init` 내에 위치해 있어 아직 UI가 그려지기 전 상태였음
* 원인 2: `PublishRelay`는 초기값이 없어 UI 바인딩 직후 데이터가 존재하지 않음
* 해결:

  * `bind()`를 `viewDidLoad()`로 이동하여 View 구성 이후 상태에서 데이터 바인딩
  * `PublishRelay` → `BehaviorRelay`로 변경하여 초기값을 전달하도록 수정


  ```swift
  // 잘못된 위치
  init(viewModel: SearchResultDetailViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
      bind() // ❌ 아직 UI 구성 전이라 효과 없음
  }
  
  // 변경된 위치
  override func viewDidLoad() {
      super.viewDidLoad()
      configureStyle()
      configureHierarchy()
      configureLayout()
      bind() // ✅ UI 구성 이후 바인딩
  }
  ```

* `bind` 메소드를 먼저 호출해도, 초기 값으로 가지고 있을 수 있도록 `DetailViewState` 내 바인딩 속성을 아래와 같이 초기값을 가지는 `BehaviorRelay`로 설정:

  ```swift
  struct DetailViewState {
      var bindedBookSubject = BehaviorRelay<BookEntity?>(value: nil)
  }
  ```

🔧 **향후 리팩토링 방향**:
* 이 값은 반복적으로 변경되지 않는 단일 데이터이므로 `Relay`가 아닌 단순 `state` 변수로 전달하는 방식이 적절함
  * `BehaviorRelay` → 일반 변수로 대체
  * ViewModel이 상태를 관리하지 않고, 단순히 바인딩용 데이터를 한번 넘기는 구조로 수정 예정

<!--### 📍 메모리 누수 발생

* 원인: 클로저 캡처 시 `self` 강한 참조 → 순환 참조 발생
* 해결: 모든 클로저에서 `[weak self]` 처리 → `Memory Graph Debugger`로 확인 완료-->

<br>

