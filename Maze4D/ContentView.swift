//
//  ContentView.swift
//  Maze4D
//
//  Created by Yuta Koshizawa on 2023/04/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GameView(size: Vector4D(x: 5, y: 5, z: 5, w: 5))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
