//
//  AdaptiveLayoutLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/26/26.
//

import SwiftUI

/*
 ForEach 문법, 특히 id: \.self에 대해.
 ForEach(1...5, id: \.self) { number in
    Text("행 \(number)")
 }
 id는 항목의 정체성을 구분하는 기준. \.self라고 하면 각 항목의 값 자체를 가리키는 키 경로.
 \.name -> 항목의 name 프로퍼티
 \.id -> 항목의 id 프로퍼티
 \.self -> 프로퍼티 하나가 아니라 항목 전체 값

 // 정수 값을 가리키는 키 경로를 만들어 값을 읽음
 let identity: KeyPath<Int, Int> = \Int.self
 let number = 7
 let result = number[keyPath: identity] // 7

 식별자는 화면 갱신 전후에 같은 항목인지 구분하기 위해 사용. 같은 컬렉션 안에서 중복 ID 없어야 하고, 같은 항목이라면 ID가 바뀌지 않도록 유지하는 것이 적절.
 Identifialbe을 채택하면 그 타입의 id를 사용하기 때문에 id:를 생략할 수 있음.
 */

// \.self 좀 더 설명
struct Test {
    struct Employee {
        let id: Int
        let name: String
    }

    func test() {
        let employee = Employee(id: 101, name: "Name")

        // employee.id는 101
        let identifier = employee.id
        let name = employee.name

        // \Employee.id는 "Employee가 주어지면 그 안의 id로 접근"
        // KeyPath<출발 타입, 경로를 통해 얻는 타입> = Employee의 id로 접근하는 경로
        let idPath: KeyPath<Employee, Int> = \Employee.id

        //ForEach에서 KeyPath를 요구하는 이유
        //ForEach는 여러 항목을 받기 때문에 각 항목에서 어떤 값을 어디서 얻으면 되는지 규칙이 필요해짐.
        // 항목 추론이 되기 때문에 Employee를 생략하고 .id만 적어도 된다.
        let employees = [employee]
        let _ = ForEach(employees, id: \Employee.id) { employee in
            Text(employee.name)
        }

        /*
         employee.id    특정 직원의 ID 값
         \Employee.id    직원에서 ID를 얻는 경로
         \Int.self    정수에서 그 정수 자체를 얻는 경로
         \.self    출발 타입을 생략한 동일한 경로
         */
    }
}

// Grid 말고도 Table이라는게 있다고 함.

/*
 Lazy가 늦추는 것
 View 생성이 정확히는 데이터 준비, View 값 구성, 자식 계층 구성, 레이아웃, 화면 렌더링 등을 함.
 일반 Stack은 화면 밖에 있는 자식까지 포함해 전체 자식 계층을 구성하고 배치. -> 전체 크기 파악 가능.
 Lazy는 모든 행의 내부 구성을 처음ㅈ부터 전부 펼쳐 측정하는 작업을 미룸. -> 자식의 body 평가와 레이아웃 같은 앞 단계의 작업도 미뤄질 수 있음.
 1,000개의 행을 예시로 들자면 데이터 자체는 이미 메모리에 있지만 각 행의 View 계층은 필요한 부분만 구성.
 -> Lazy는 대신 측정하지 않은 행의 높이는 추정해야 하기 때문에 스크롤 위치나 전체 콘텐츠 크기 추정이 개입.
 */

struct AdaptiveLayoutLabView: View {
    var body: some View {
        viewThatFitsLab
            .padding()
    }

    // 두 배치 후보에서 공통으로 사용할 첫 번째 패널을 정의한다.
    private var firstPanel: some View {
        Text("첫 번째 영역")
            .frame(width: 180, height: 60)
            .background(.orange.opacity(0.3))
    }
    // 두 배치 후보에서 공통으로 사용할 두 번째 패널을 정의한다.
    private var secondPanel: some View {
        Text("두 번째 영역")
            .frame(width: 180, height: 60)
            .background(.green.opacity(0.3))
    }
    // 가로 배치가 들어가면 사용하고, 들어가지 않으면 세로 배치를 선택한다.
    private var viewThatFitsLab: some View {
        ViewThatFits(in: .horizontal) {
            HStack(spacing: 12) {
                firstPanel
                secondPanel
            }

            VStack(alignment: .leading, spacing: 12) {
                firstPanel
                secondPanel
            }
        }
        .border(.green, width: 2)
        .frame(width: 320, alignment: .leading)
        .border(.blue, width: 2)
    }

    // 너비 340 안에 최소 너비 100인 열들을 배치하고 셀은 필요할 때 생성한다.
    private var lazyGridLab: some View {
        let columns = [
            GridItem(.adaptive(minimum: 100), spacing: 12)
        ]

        return ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(1...60, id: \.self) { number in
                    Text("셀 \(number)")
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(.orange.opacity(0.3))
                }
            }
            .frame(width: 340)
            .border(.green, width: 2)
        }
        .frame(width: 380, height: 220)
        .border(.blue, width: 2)
    }

    // 많은 행을 세로로 스크롤하며 LazyVStack의 기본 사용 형태를 익힌다.
    private var lazyStackLab: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(1...1000, id: \.self) { number in
                    Text("행 \(number)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 32)
                        .background(.blue.opacity(0.1))
                }
            }
        }
        .frame(width: 320, height: 180)
        .border(.blue, width: 2)
    }

    // 서로 다른 행의 셀들이 열 너비를 공유하는지 확인한다.
    private var gridLab: some View {
        Grid(
            alignment: .leading,
            horizontalSpacing: 12,
            verticalSpacing: 8
        ) {
            GridRow {
                Text("항목 A------")
                    //                    .frame(width: 80, height: 32)
                    .background(.orange.opacity(0.3))

                Text("값 A")
                    //                    .frame(width: 160, height: 32)
                    .background(.green.opacity(0.3))
            }

            GridRow {
                Text("항목 B")
                    //                    .frame(width: 120, height: 32)
                    .background(.orange.opacity(0.3))

                Text("값 B--------")
                    //                    .frame(width: 60, height: 32)
                    .background(.green.opacity(0.3))
            }
        }
        .border(.blue, width: 2)
    }

    // 높이 160의 표시 영역에서 높이 448인 콘텐츠를 세로로 스크롤한다.
    private var scrollMeasurementLab: some View {
        ScrollView(.vertical) {
            VStack(spacing: 12) {
                ForEach(1...5, id: \.self) { number in
                    Rectangle()
                        .fill(.orange.opacity(0.3))
                        .frame(height: 80)
                        .overlay {
                            Text("행 \(number)")
                        }
                }
            }
            .border(.green, width: 2)
        }
        .frame(width: 300, height: 160)
        .border(.blue, width: 2)
    }
}

#Preview {
    AdaptiveLayoutLabView()
}
