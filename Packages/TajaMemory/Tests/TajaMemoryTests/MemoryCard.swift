import Testing

@testable import TajaMemory

@Suite
struct MemoryCardTests {
    @Test
    func should_be_concealed_initially() async throws {
        #expect(MemoryCard().state == .concealed)
    }

    @Test
    func should_be_revealed_when_revealing() async throws {
        var memoryCard = MemoryCard()

        memoryCard.reveal()

        #expect(memoryCard.state == .revealed)
    }

    @Test
    func should_be_concealed_when_concealing() async throws {
        var memoryCard = MemoryCard()
        memoryCard.reveal()

        memoryCard.conceal()

        #expect(memoryCard.state == .concealed)
    }
}
