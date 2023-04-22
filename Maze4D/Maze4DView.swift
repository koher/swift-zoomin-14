import SwiftUI

struct Maze4DView: View {
    let maze: Maze4D
    let cellSize: CGFloat
    let currentPosition: Vector4D<Int>
    
    var body: some View {
        Canvas { context, size in
            for w in (1..<(maze.size.w - 1)) {
                for z in (1..<(maze.size.z - 1)) {
                    for y in (0..<maze.size.y) {
                        for x in (0..<maze.size.x) {
                            let fillColor = cellColor(x: x, y: y, z: z, w: w)
                            let rect = CGRect(x: CGFloat(x) * cellSize + CGFloat(z - 1) * (CGFloat(maze.size.x) * cellSize + cellSize),
                                              y: CGFloat(y) * cellSize + CGFloat(w - 1) * (CGFloat(maze.size.y) * cellSize + cellSize),
                                              width: cellSize,
                                              height: cellSize)
                            context.fill(Path(rect), with: .color(fillColor))
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
