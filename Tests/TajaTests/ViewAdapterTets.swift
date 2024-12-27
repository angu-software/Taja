//
//  ViewAdapterTets.swift
//  TajaTests
//
//  Created by Andreas Guenther on 27.12.24.
//

import Testing

import TestingTags

@testable import Taja

@MainActor
struct ViewAdapterTets {

    @Test(.tags(.acceptanceTest))
    func should_calculate_card_index_for_first_cell_in_first_row() async throws {
        let viewAdapter = ViewAdapter()

        #expect(viewAdapter.cardIndex(forRow: 0, column: 0) == 0)
    }

    @Test(.tags(.acceptanceTest))
    func should_calculate_card_index_for_last_cell_in_first_row() async throws {
        let viewAdapter = ViewAdapter()

        #expect(viewAdapter.cardIndex(forRow: 0, column: 2) == 2)
    }

    @Test
    func should_calculate_card_index_for_last_cell_in_last_row() async throws {
        let viewAdapter = ViewAdapter()

        //[0,1,2|,3,4,5|,6,7,8|,9,10,11|,12,13,14|,15,16,17]
        // 0    |1     |2     |3       |4        |5

        #expect(viewAdapter.cardIndex(forRow: 5, column: 2) == 17)
    }
}
