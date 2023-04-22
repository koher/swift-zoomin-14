import SwiftUI

struct Maze4DView: View {
    let maze: Maze4D
    let cellSize: CGFloat
    let currentPosition: Vector4D<Int>

    var body: some View {
        VStack(spacing: cellSize) {
            ForEach(1..<(maze.size.w - 1), id: \.self) { w in
                HStack(spacing: cellSize) {
                    ForEach(1..<(maze.size.z - 1), id: \.self) { z in
                        VStack(spacing: 0) {
                            ForEach(0..<maze.size.y, id: \.self) { y in
                                HStack(spacing: 0) {
                                    ForEach(0..<maze.size.x, id: \.self) { x in
                                        Rectangle()
                                            .fill(cellColor(x: x, y: y, z: z, w: w))
                                            .frame(width: cellSize, height: cellSize)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func cellColor(x: Int, y: Int, z: Int, w: Int) -> Color {
        let position = Vector4D(x: x, y: y, z: z, w: w)
        if position == currentPosition {
            return .green
        }

        let cell = maze[position]

        switch cell {
        case .path, .start:
            return .white
        case .wall:
            return .black
        case .goal:
            return .red
        }
    }
}
