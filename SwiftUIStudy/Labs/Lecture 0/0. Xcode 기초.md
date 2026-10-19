# Xcode 프로젝트 구조 및 파일별 역할
- .xcodeproj    Xcode 프로젝트 구성 및 빌드 설정
- .xcassets     리소스 관리

## xcodeproj
Xcode Project의 확장자. 하나의 파일이 아니라 여러 파일을 담고 있는 디렉터리 형태의 패키지.(패키지는 macOS에서 디렉터리를 하나의 파일처럼 다룰 수 있도록 하는 구조. 우클릭 후 패키지 내용 보기 할 수 있음.)
xcodeproj 안에는 pbxproj, xcworkspace, xcuserdata가 존재.

### pbxproj
Xcode가 프로젝트의 구성 정보와 빌드 설정 등을 기록하는 파일.
프로젝트에 속한 Target, Target별 빌드 설정, 소스 파일 및 리소스 관련 구성, Build Configuration, Target 사이의 의존성, 빌드 단계 등을 포함.

### xcworkspace
여러 프로젝트와 관련 요소를 하나의 작업 공간으로 묶는 단위.

## xcassets
프로그램이 사용하는 리소스. Asset Catalog는 리소스들을 관리하는 Apple의 파일 구성 방식.
여기 안에 있는 AccentColor.colorset 같은건 SwiftUI에서 Color.accentColor 같이 접근할 수 있다.

## Info.plist
속성과 값을 저장하는 Apple의 데이터 파일 형식. 앱 이름이나 버전 등의 정보를 저장. 앱의 식별자, 버전, 실행 정보 등 운영체제가 필요로 하는 메타데이터 제공.
Target의 Build Settings에 Generate Info.plist File = Yes 같이 되어 있으면 자동 생성된다.

## Project와 Target의 차이
### Target
빌드하여 만들어 낼 결과물 또는 그 결과물을 만드는 데 필요한 구성을 지정하는 단위. Apple은 앱, 프레임워크, 앱 익스텐션, 테스트 등의 빌드 결과물을 정의한다고 함.
하나의 Xcode 프로젝트에 여러 Target들이 있을 수 있다.

## Scheme과 Build Configuration
### Scheme
어떤 Target을 어떤 방식으로 빌드, 실행, 테스트할지 정의한 작업 구성.
Scheme에는 Build, Run, Test, Profile(성능 분석), Analyze(정적 분석), Archive 등이 포함된다.

### Build Configuration
프로그램 빌드 시 사용할 설정의 집합.
Debug, Release 등.

- Project -> 어떤 소프트웨어들을 관리하는지.
- Target -> 무엇을 빌드하는지.
- Scheme -> 어떤 작업을 어떤 방식으로 수행하는지.
- Build COnfiguration -> 어떤 빌드 설정을 사용하는지.

⌘R을 누르면 Scheme -> Run -> Target: SwiftUIStudyAPP, Configuration: Debug -> 앱 빌드 -> 앱 실행 순으로 진행.

## Build Settings
빌드 과정에서 사용할 옵션들.
Swift Language Version, Produc Bundle Identifier, macOS Deployment Target 등.

## Build Phases
실제 빌드 과정에서 수행할 작업들.
예를 들어 소스 코드 컴파일 -> 프레임워크 연결 -> 리소스 처리 -> 앱 패키징 등.

---

# Xcode에서 논리적 그룹 생성 및 관리
- Group: Xcode의 Project Navigator에서 파일을 정리하기 위한 묶음.
- Folder: 실제 디스크에 존재하는 디렉터리.

일반적으로 New Group을 하면 실제 폴더와 연결된 그룹을 생성함. 실제 폴더 없이 그룹만 만들려면 우클릭하고 ⌥를 누르면 나오는 New Group without Folder를 선택.
이렇게 만든 그룹은 실제 디스크에 새로운 폴더를 생성하지 않음.

파일을 논리적 그룹 안에서 정리하면 파일 위치가 변하지 않음. 실제 폰더와 연결된 그룹으로 이동하면 파일도 함께 이동함.

깃으로 관리할거면 실제 폴더로 관리하는게 나음. 

---
# Workspace란?
여러 Xcode 프로젝트를 하나의 개발 환경에서 함께 열고 관리하는 상위 단위. 각 프로젝트 간의 의존성, 빌드, 코드 탐색 등도 할 수 있다.
```
Workspace           <- 여러 프로젝트를 관리
│
├── Project A       <- 관련 소스, 리소스, 타깃 및 빌드 설정 관리
│   ├── Target A1   <- 실제로 빌드할 결과물 정의
│   └── Target A2
│
├── Project B
│   └── Target B1
│
└── Project C
    └── Target C1
```

다음과 같이 고려하면 된다.
- 하나의 앱과 관련 테스트 -> 1 Project, n Target
- 앱과 전용 프레임워크 -> 1 Project, n Target
- 독립적으로 관리되는 여러 프로젝트 -> Workspace
- 기존 프로젝트 여러 개를 함께 개발 -> Workspace


