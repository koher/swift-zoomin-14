import Foundation

struct Maze4D {
    enum Cell {
        case path
        case wall
        case start
        case goal
    }

    let size: Vector4D<Int>
    private var cells: [Cell]

    init(size: Vector4D<Int>) {
        self.size = size
        self.cells = Array(repeating: .wall, count: size.x * size.y * size.z * size.w)
    }

    private func index(from position: Vector4D<Int>) -> Int {
        return position.x + size.x * (position.y + size.y * (position.z + size.z * position.w))
    }

    subscript(position: Vector4D<Int>) -> Cell {
        get {
            return cells[index(from: position)]
        }
        set {
            cells[index(from: position)] = newValue
        }
    }
}

import Foundation

extension Maze4D {
    static func makeRandomly(size: Vector4D<Int>) -> Maze4D {
        var maze = Maze4D(size: size)
        var visitedCells = Set<Int>()
        var stack = [Vector4D<Int>]()
        
        let start = Vector4D(x: 1, y: 1, z: 1, w: 1)
        let goal = Vector4D(x: size.x - 2, y: size.y - 2, z: size.z - 2, w: size.w - 2)
        
        func isValidPosition(_ position: Vector4D<Int>) -> Bool {
            return position.x >= 1 && position.x < size.x - 1 &&
                   position.y >= 1 && position.y < size.y - 1 &&
                   position.z >= 1 && position.z < size.z - 1 &&
                   position.w >= 1 && position.w < size.w - 1
        }
        
        func getNeighbors(_ position: Vector4D<Int>) -> [Vector4D<Int>] {
            let offsets = [Vector4D(x: 0, y: 0, z: 0, w: 2),
                           Vector4D(x: 0, y: 0, z: 0, w: -2),
                           Vector4D(x: 0, y: 0, z: 2, w: 0),
                           Vector4D(x: 0, y: 0, z: -2, w: 0),
                           Vector4D(x: 0, y: 2, z: 0, w: 0),
                           Vector4D(x: 0, y: -2, z: 0, w: 0),
                           Vector4D(x: 2, y: 0, z: 0, w: 0),
                           Vector4D(x: -2, y: 0, z: 0, w: 0)]
            
            var neighbors = [Vector4D<Int>]()
            
            for offset in offsets {
                let newPosition = position + offset
                if isValidPosition(newPosition) {
                    neighbors.append(newPosition)
                }
            }
            
            return neighbors
        }
        
        func visit(_ position: Vector4D<Int>) {
            visitedCells.insert(maze.index(from: position))
            maze[position] = .path
            
            let neighbors = getNeighbors(position)
            var shuffledNeighbors = neighbors.shuffled()
            
            while !shuffledNeighbors.isEmpty {
                let neighbor = shuffledNeighbors.removeFirst()
                let index = maze.index(from: neighbor)
                
                if !visitedCells.contains(index) {
                    let middle = (position + neighbor) / 2
                    maze[middle] = .path
                    
                    stack.append(position)
                    visit(neighbor)
                }
            }
            
            if !stack.isEmpty {
                let previousPosition = stack.removeLast()
                visit(previousPosition)
            }
        }
        
        // Initialize maze with all walls
        for x in 0..<size.x {
            for y in 0..<size.y {
                for z in 0..<size.z {
                    for w in 0..<size.w {
                        let position = Vector4D(x: x, y: y, z: z, w: w)
                        maze[position] = .wall
                    }
                }
            }
        }
        
        // Generate maze using depth-first search
        visit(start)
        
        // Set start and goal positions
        maze[start] = .start
        maze[goal] = .goal
        
        return maze
    }
}
