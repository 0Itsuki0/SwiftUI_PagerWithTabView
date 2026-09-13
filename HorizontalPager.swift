//
//  HorizontalPager.swift
//
//  Created by Itsuki on 2026/09/13.
//

import SwiftUI

struct HorizontalPagerDemo: View {
    init() {
        let startIndex = (0..<10).map({ start in return start * 7 })
        self.startIndex = startIndex
        self._selected = State(initialValue: startIndex[3])
        self._tabSelection = State(initialValue: startIndex[3])
    }

    private let startIndex: [Int]
    @State private var selected: Int?
    @State private var tabSelection: Int

    var body: some View {

        Text("Horizontal Pager")
            .font(.title2)
            .fontWeight(.bold)

        Spacer()
            .frame(height: 32)

        Text("With ScrollView")
            .font(.headline)

        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(startIndex, id: \.self) { start in
                    page(start: start)
                        .containerRelativeFrame(.horizontal)
                        .id(start)
                }
            }
            .scrollTargetLayout()
            .fixedSize(horizontal: false, vertical: true)
        }
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: $selected, anchor: .leading)
        .scrollIndicators(.hidden)
        .padding(.vertical, 8)
        .background(.secondary.opacity(0.3))

        Spacer()
            .frame(height: 32)

        Text("With TabView")
            .font(.headline)

        TabView(selection: $tabSelection) {
            ForEach(startIndex, id: \.self) { start in
                page(start: start)
                    .tag(start)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        // explicit frame on the tabview required
        // so that it is not taking over the full vertical space (default behavior)
        // fixedSize won't work here as it will make the vertical goes to 0
        .frame(height: 24)
        .padding(.vertical, 8)
        .background(.secondary.opacity(0.3))

    }

    @ContentBuilder
    private func page(start: Int) -> some View {
        HStack {
            ForEach(start..<start + 7, id: \.self) { number in
                Text(number, format: .number)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
