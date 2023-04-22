import SwiftUI
import Combine

import SwiftUI

import SwiftUI

struct GameView: View {
    @StateObject private var state: GameViewState
    @State private var showAlert: Bool = false

    init(size: Vector4D<Int>) {
        _state = StateObject(wrappedValue: GameViewState(size: size))
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Maze4DView(maze: state.maze,
                           cellSize: min(geometry.size.width / CGFloat(state.maze.size.x * (state.maze.size.z - 2) + (state.maze.size.z - 3)),
                                         geometry.size.height / CGFloat(state.maze.size.y * (state.maze.size.w - 2) + (state.maze.size.w - 3))),
                           currentPosition: state.currentPosition)
                DirectionInputView { direction in
                    state.move(direction: direction)
                    if state.hasReachedGoal {
                        showAlert = true
                    }
                }
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("おめでとう！"),
                  message: Text("ゴールに到達しました。"),
                  primaryButton: .default(Text("リトライ"), action: {
                      state.retry()
                      showAlert = false
                  }),
                  secondaryButton: .default(Text("次へ"), action: {
                      state.nextLevel(size: state.maze.size)
                      showAlert = false
                  }))
        }
    }
}

@MainActor
final class GameViewState: ObservableObject {
    @Published private(set) var maze: Maze4D
    @Published private(set) var currentPosition: Vector4D<Int>
    @Published private(set) var hasReachedGoal: Bool = false

    init(size: Vector4D<Int>) {
        maze = Maze4D.makeRandomly(size: size)
        currentPosition = Vector4D(x: 1, y: 1, z: 1, w: 1)
    }

    func move(direction: Vector4D<Int>) {
        let newPosition = currentPosition + direction
        if maze[newPosition] != .wall {
            currentPosition = newPosition
            if maze[newPosition] == .goal {
                hasReachedGoal = true
            }
        }
    }

    func retry() {
        currentPosition = Vector4D(x: 1, y: 1, z: 1, w: 1)
        hasReachedGoal = false
    }

    func nextLevel(size: Vector4D<Int>) {
        maze = Maze4D.makeRandomly(size: size)
        currentPosition = Vector4D(x: 1, y: 1, z: 1, w: 1)
        hasReachedGoal = false
    }
}
